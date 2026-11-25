# DA-01: Enterprise Business Intelligence Suite

## Objective
Build a multi-region sales BI model with an executive KPI view, regional analysis,
product analysis, time trends, drill-through and region-based row-level security.

## Data
The `data` folder contains a small, clearly labelled synthetic sales dataset for
demonstrating the required star schema. It is not real company data.

## Model
- FactSales: one row per sales order line.
- DimCustomer: customer attributes.
- DimProduct: product attributes.
- DimTerritory: region attributes.
- DimDate: calendar attributes.

## Build the Power BI report
1. Import all CSV files from `data`.
2. Apply data types and quality checks in Power Query.
3. Create the relationships listed in `powerbi/Power_Query_M_Examples.txt`.
4. Add measures from `powerbi/Measures.dax`.
5. Create report pages:
   - Executive Overview: Sales, Profit, Orders, Units, Margin; monthly trend.
   - Regional Performance: sales/profit by region and region slicer.
   - Product Performance: sales by category/product.
   - Customer Analysis: sales by segment/customer.
6. Add drill-through from region and product visuals to detail pages.
7. Configure and test RegionManager RLS using `powerbi/RLS_setup.txt`.
8. Save the report as `DA01_Enterprise_BI.pbix`.

## Database scripts
`sql/01_create_schema.sql` and `sql/02_analysis_queries.sql` are SQL Server scripts.
Load CSV data into the matching tables before running analysis queries.

## Data limitation
The supplied data is synthetic sample data to make the project runnable. For a production
submission, replace it with AdventureWorks or another approved business dataset.
