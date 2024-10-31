SELECT 
    d.Date,
    AVG(fs.TotalAmount) AS AvgTotalAmount,
    AVG(fs.Discount) AS AvgDiscount,
    COUNT(fs.SalesID) AS NumberOfTransactions
FROM 
    northwind.FactSales fs
JOIN 
    northwind.DimDate d ON fs.DateID = d.DateID
WHERE 
    d.Date BETWEEN '2023-01-01' AND '2023-03-31'  -- Specify your date range here
GROUP BY 
    d.Date
ORDER BY 
    d.Date;


SELECT 
    p.ProductID,
    p.ProductName,
    COUNT(fs.SalesID) AS NumberOfTransactions,
    SUM(fs.TotalAmount) AS TotalSales
FROM 
    northwind.FactSales fs
JOIN 
    northwind.DimProduct p ON fs.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    NumberOfTransactions ASC
LIMIT 5;  -- Change to LIMIT -5 for the worst products


SELECT 
    c.CustomerID,
    c.CompanyName,
    COUNT(fs.SalesID) AS NumberOfTransactions,
    SUM(fs.TotalAmount) AS TotalPurchaseAmount
FROM 
    northwind.FactSales fs
JOIN 
    northwind.DimCustomer c ON fs.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerID, c.CompanyName
ORDER BY 
    TotalPurchaseAmount ASC
LIMIT 5;  -- Change to LIMIT -5 for the worst customers



SELECT 
    DATE_TRUNC('month', d.Date) AS MonthStart,
    SUM(fs.TotalAmount) AS TotalSales,
    SUM(fs.QuantitySold) AS TotalQuantity
FROM 
    northwind.FactSales fs
JOIN 
    northwind.DimDate d ON fs.DateID = d.DateID
WHERE 
    EXTRACT(DAY FROM d.Date) BETWEEN 1 AND 7
GROUP BY 
    MonthStart
ORDER BY 
    MonthStart;
	
	
SELECT 
p.CategoryID,
SUM(fs.TotalAmount) AS TotalSales,
DATE_TRUNC('week', d.Date) AS WeekStart
FROM 
    northwind.FactSales fs
JOIN 
    northwind.DimDate d ON fs.DateID = d.DateID
JOIN 
    northwind.DimProduct p ON fs.ProductID = p.ProductID
WHERE 
    d.Date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    p.CategoryID, WeekStart
ORDER BY 
    WeekStart, TotalSales DESC;


WITH MonthlySales AS (
    SELECT 
        EXTRACT(YEAR FROM d.Date) AS Year,
        EXTRACT(MONTH FROM d.Date) AS Month,
        c.Country,
        p.CategoryID,
        SUM(fs.TotalAmount) AS TotalSales
    FROM 
        northwind.FactSales fs
    JOIN 
        northwind.DimDate d ON fs.DateID = d.DateID
    JOIN 
        northwind.DimProduct p ON fs.ProductID = p.ProductID
    JOIN 
        northwind.DimCustomer c ON fs.CustomerID = c.CustomerID
    GROUP BY 
        Year, Month, c.Country, p.CategoryID
)
SELECT 
    Year,
    Month,
    Country,
    CategoryID,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY TotalSales) AS MedianSales
FROM 
    MonthlySales
GROUP BY 
    Year, Month, Country, CategoryID
ORDER BY 
    Year, Month, Country, CategoryID;


SELECT 
    p.CategoryID,
    SUM(fs.TotalAmount) AS TotalSales
FROM 
    northwind.FactSales fs
JOIN 
    northwind.DimProduct p ON fs.ProductID = p.ProductID
GROUP BY 
    p.CategoryID
ORDER BY 
    TotalSales DESC;

