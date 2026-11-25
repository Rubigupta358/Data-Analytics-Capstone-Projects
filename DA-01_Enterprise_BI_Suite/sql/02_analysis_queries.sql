-- Executive KPIs
SELECT SUM(SalesAmount) AS TotalSales, SUM(ProfitAmount) AS TotalProfit,
       SUM(Quantity) AS UnitsSold, COUNT(DISTINCT SalesOrderKey) AS Orders
FROM FactSales;

-- Sales by region
SELECT t.Region, SUM(f.SalesAmount) AS Sales, SUM(f.ProfitAmount) AS Profit
FROM FactSales f JOIN DimTerritory t ON f.TerritoryKey=t.TerritoryKey
GROUP BY t.Region ORDER BY Sales DESC;

-- Sales by product category
SELECT p.Category, SUM(f.SalesAmount) AS Sales
FROM FactSales f JOIN DimProduct p ON f.ProductKey=p.ProductKey
GROUP BY p.Category ORDER BY Sales DESC;

-- Monthly sales
SELECT d.[Year], d.MonthNumber, d.MonthName, SUM(f.SalesAmount) AS Sales
FROM FactSales f JOIN DimDate d ON f.OrderDate=d.Date
GROUP BY d.[Year], d.MonthNumber, d.MonthName
ORDER BY d.[Year], d.MonthNumber;
