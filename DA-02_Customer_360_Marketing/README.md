# DA-02: Customer 360 and Marketing Attribution

## Objective
Combine web session, CRM and order information to create a customer profile, RFM segments,
marketing attribution views and campaign performance measures.

## Data and source notes
- `data/raw/` contains synthetic CRM, session, order and ad-spend sample data for a repeatable local demo.
- `bigquery/` contains queries for the public GA4 ecommerce sample dataset.
- The public GA4 sample is obfuscated and covers the dates used in the included queries.
- Synthetic sample data is not real customer or campaign data.

## Run the local analysis
From this folder:
    python -m pip install -r python/requirements.txt
    python python/customer_analysis.py

Outputs are written to `data/processed/`.

## dbt
The `dbt_project/` folder contains staging and customer profile model examples.
Configure a BigQuery profile and create source tables under `analytics_raw` before running dbt.
The local synthetic CSV analysis does not itself prove a dbt build against BigQuery.

## Tableau workbook
Use `tableau/Dashboard_Guide.txt` to build the dashboard and save as
`DA02_Customer360_Attribution.twbx`.

## Metrics
- RFM: Recency, Frequency, Monetary value.
- ROI = (Revenue - Ad Spend) / Ad Spend.
- CPA = Ad Spend / Orders.
- Attribution examples include first-touch, last-touch and linear credit.
