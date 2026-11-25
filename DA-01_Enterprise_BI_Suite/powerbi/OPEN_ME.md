# Power BI project – how to turn this into the final `.pbix` (≈ 3 minutes)

This folder is a **Power BI Project (PBIP)**: the full model (5 tables + UserRegion, 4 relationships, 16 DAX measures, date table, RLS roles `RegionManager` / `Executive`) and a 3-page report (Executive Summary, Sales Analysis, Customers & Regions).

1. Power BI Desktop → *File → Options → Preview features* → tick **Power BI Project (.pbip) save option** and **Store semantic model using TMDL format** → restart.
2. *File → Open report* → pick `EnterpriseBI.pbip`.
3. *Transform data → Edit parameters* → set **DataFolder** to the full path of this repo's `DA-01_Enterprise_BI/data` folder → *Apply changes*.
4. Check each page loads; adjust visual layout if you like.
5. **File → Save as → `EnterpriseBI.pbix`** (this is the file to submit, alongside this project folder).
6. RLS: *Modeling → View as → RegionManager* → Other user `north.manager@yourtenant.onmicrosoft.com` → only North should show. Edit `data/UserRegion.csv` with real emails before publishing.

Data note: sales only cover 2024, so *Sales Previous Year* / *YoY Growth %* are blank until a second year of data exists (the measures are correct). Rolling 3-month, YTD, QTD and MoM work.
