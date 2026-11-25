CREATE TABLE DimCustomer (
    CustomerKey INT PRIMARY KEY, CustomerName VARCHAR(100),
    Region VARCHAR(30), Country VARCHAR(60), CustomerSegment VARCHAR(40)
);
CREATE TABLE DimProduct (
    ProductKey INT PRIMARY KEY, ProductName VARCHAR(100),
    Category VARCHAR(50), Subcategory VARCHAR(50),
    UnitCost DECIMAL(12,2), UnitPrice DECIMAL(12,2)
);
CREATE TABLE DimTerritory (
    TerritoryKey INT PRIMARY KEY, Region VARCHAR(30),
    Country VARCHAR(60), GroupName VARCHAR(50)
);
CREATE TABLE DimDate (
    Date DATE PRIMARY KEY, [Year] INT, MonthNumber INT,
    MonthName VARCHAR(20), Quarter VARCHAR(2)
);
CREATE TABLE FactSales (
    SalesOrderKey INT PRIMARY KEY, OrderDate DATE,
    CustomerKey INT, ProductKey INT, TerritoryKey INT,
    Quantity INT, DiscountPct DECIMAL(5,2),
    SalesAmount DECIMAL(14,2), CostAmount DECIMAL(14,2),
    ProfitAmount DECIMAL(14,2),
    FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),
    FOREIGN KEY (TerritoryKey) REFERENCES DimTerritory(TerritoryKey),
    FOREIGN KEY (OrderDate) REFERENCES DimDate(Date)
);
