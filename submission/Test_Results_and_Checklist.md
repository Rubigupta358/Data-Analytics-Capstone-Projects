# Test Results and Submission Checklist

## Local checks to run
### DA-01
- [ ] All five CSV files import successfully.
- [ ] FactSales keys match the dimension keys.
- [ ] Date relationship is active and uses DimDate[Date].
- [ ] Total Sales, Total Profit, Orders and Units Sold return values.
- [ ] YTD, YoY and rolling 3-month measures calculate.
- [ ] RegionManager role is tested with View As.
- [ ] Drill-through works from region and product visuals.

### DA-02
- [ ] Python script runs without errors.
- [ ] customer_360.csv is created.
- [ ] rfm_segments.csv is created.
- [ ] attribution_orders.csv is created.
- [ ] campaign_performance.csv is created.
- [ ] BigQuery GA4 SQL runs in the selected project.
- [ ] dbt sources are configured and dbt tests pass.
- [ ] Tableau dashboard filters and metrics work.

## Evidence to include
- Power BI report screenshots and `.pbix`.
- Tableau dashboard screenshots and `.twbx`.
- BigQuery query result screenshot.
- dbt run/test output.
- Python execution output.
- Short demo recording or deployed demo URL.

Do not mark a check complete until it has been tested.
