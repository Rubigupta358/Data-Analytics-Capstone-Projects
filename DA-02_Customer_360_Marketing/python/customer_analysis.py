from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw"
OUT = ROOT / "data" / "processed"
OUT.mkdir(parents=True, exist_ok=True)

customers = pd.read_csv(RAW / "crm_customers.csv", parse_dates=["signup_date"])
sessions = pd.read_csv(RAW / "ga4_sessions_sample.csv", parse_dates=["session_date"])
orders = pd.read_csv(RAW / "orders.csv", parse_dates=["order_date"])
ad = pd.read_csv(RAW / "ad_spend.csv", parse_dates=["date"])

# Identity resolution: sample data already shares customer_id across CRM, sessions and orders.
session_summary = sessions.groupby("customer_id").agg(
    sessions=("session_id", "nunique"),
    first_session=("session_date", "min"),
    last_session=("session_date", "max")
).reset_index()

order_summary = orders.groupby("customer_id").agg(
    orders=("order_id", "nunique"),
    revenue=("revenue", "sum"),
    last_order=("order_date", "max")
).reset_index()

profile = customers.merge(session_summary, on="customer_id", how="left").merge(
    order_summary, on="customer_id", how="left"
)
profile[["sessions", "orders", "revenue"]] = profile[["sessions", "orders", "revenue"]].fillna(0)

# RFM using latest order date in the sample.
as_of = orders["order_date"].max() + pd.Timedelta(days=1)
rfm = orders.groupby("customer_id").agg(
    Recency=("order_date", lambda x: (as_of - x.max()).days),
    Frequency=("order_id", "nunique"),
    Monetary=("revenue", "sum")
).reset_index()
for col in ["Recency", "Frequency", "Monetary"]:
    ascending = col == "Recency"
    rfm[col + "_Score"] = pd.qcut(rfm[col].rank(method="first"), 4, labels=[1,2,3,4] if ascending else [1,2,3,4]).astype(int)
rfm["RFM_Score"] = rfm["Recency_Score"].astype(str) + rfm["Frequency_Score"].astype(str) + rfm["Monetary_Score"].astype(str)
rfm["Segment"] = "Needs Attention"
rfm.loc[(rfm["Frequency_Score"] >= 3) & (rfm["Monetary_Score"] >= 3), "Segment"] = "Loyal / High Value"
rfm.loc[(rfm["Recency_Score"] >= 3) & (rfm["Frequency_Score"] <= 2), "Segment"] = "New / Promising"

profile.to_csv(OUT / "customer_360.csv", index=False)
rfm.to_csv(OUT / "rfm_segments.csv", index=False)

# Attribution models: session source associated to order source in the sample.
first_touch = sessions.sort_values("session_date").groupby("customer_id").first().reset_index()
last_touch = sessions.sort_values("session_date").groupby("customer_id").last().reset_index()
attrib = orders.merge(first_touch[["customer_id","source"]].rename(columns={"source":"first_touch"}),
                      on="customer_id", how="left")
attrib = attrib.merge(last_touch[["customer_id","source"]].rename(columns={"source":"last_touch"}),
                      on="customer_id", how="left")
attrib["first_touch_credit"] = attrib["revenue"]
attrib["last_touch_credit"] = attrib["revenue"]
attrib["linear_credit"] = attrib["revenue"] / 2
attrib.to_csv(OUT / "attribution_orders.csv", index=False)

campaign = ad.groupby("channel").agg(spend=("spend","sum")).reset_index()
channel_rev = orders.groupby("source").agg(revenue=("revenue","sum"), orders=("order_id","nunique")).reset_index()
campaign = campaign.merge(channel_rev, left_on="channel", right_on="source", how="left").drop(columns=["source"])
campaign[["revenue","orders"]] = campaign[["revenue","orders"]].fillna(0)
campaign["ROI"] = (campaign["revenue"] - campaign["spend"]) / campaign["spend"].replace(0, pd.NA)
campaign["CPA"] = campaign["spend"] / campaign["orders"].replace(0, pd.NA)
campaign.to_csv(OUT / "campaign_performance.csv", index=False)
print("Customer 360, RFM, attribution and campaign outputs created.")
