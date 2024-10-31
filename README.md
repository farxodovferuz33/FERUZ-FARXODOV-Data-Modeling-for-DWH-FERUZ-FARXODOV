# FERUZ-FARXODOV-Data-Modeling-for-DWH-FERUZ-FARXODOV
FERUZ FARXODOV Data Modeling for DWH - TASK - HOMEWORK -  FERUZ FARXODOV
SQL DESCRIPTIONS ARE IN DIFFERENT FILE

,,,


Task Description

You need to use the same scripts from the NORTHWIND database that you worked with previously.

The task is divided into several steps, which must be completed in order.

Click the arrows to see more information.

Design Staging Tables and a Star Schema

The staging tables will be used for loading the initial data, and the star schema will be organized around a fact table and related dimension tables.

1. Create the following staging tables:

staging_orders
staging_order_details
staging_products
staging_customers
staging_employees
staging_categories
staging_shippers
staging_suppliers
Designing a star schema design involves creating dimension tables and a fact table.

2. Use the proposed set of dimension tables and their respective columns.

Table - DimDate:

DateID (Primary Key)
Date
Day
Month
Year
Quarter
WeekOfYear

Table - DimCustomer:

CustomerID (Primary Key)
CompanyName
ContactName
ContactTitle
Address
City
Region
PostalCode
Country
Phone

Table - DimProduct:

ProductID (Primary Key)
ProductName
SupplierID (FK)
CategoryID (FK)
QuantityPerUnit
UnitPrice
UnitsInStock

Table -  DimEmployee:

EmployeeID (Primary Key)
LastName
FirstName
Title
BirthDate
HireDate
Address
City
Region
PostalCode
Country
HomePhone
Extension

Table -  DimCategory:

CategoryID (Primary Key)
CategoryName
Description

Table -  DimShipper:

ShipperID (Primary Key)
CompanyName
Phone


Table -  DimSupplier:

SupplierID (Primary Key)
CompanyName
ContactName
ContactTitle
Address
City
Region
PostalCode
Country
Phone


And the table FactSales with the columns below:

SalesID (Primary Key)
DateID (FK to Date Dimension)
CustomerID (FK to Customer Dimension)
ProductID (FK to Product Dimension)
EmployeeID (FK to Employee Dimension)
CategoryID (FK to Category Dimension)
ShipperID (FK to Shipper Dimension)
SupplierID (FK to Supplier Dimension)
QuantitySold
UnitPrice
Discount
TotalAmount (Calculated as QuantitySold * UnitPrice - Discount)
TaxAmount


Load Data Into Staging, Transformation, and Star Schema

1. For each source table in the northwind_pg database, you need to create a corresponding staging table and load data into it. Below is an example for the Customers table.

Assuming staging tables with the same structure as the source tables have already been created, load data into staging_customer from the source Customers table.

INSERT INTO staging_customers 
SELECT * FROM Customers;

2. Repeat this process for each table listed in step 1:

staging_orders
staging_order_details
staging_products
staging_customers
staging_employees
staging_categories
staging_shippers
staging_suppliers
3. Transform the data from the staging tables and load it into the respective dimension tables. Here's an example for DimCustomer:

INSERT INTO DimCustomer (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone) 
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone 
FROM staging_customers; 

4. Repeat this process for other dimensions (DimProduct, DimEmployee, etc.), transforming the data as necessary.

5. Load it into the fact table, as shown below:

INSERT INTO FactSales (DateID, CustomerID, ProductID, EmployeeID, CategoryID, ShipperID, SupplierID, QuantitySold, UnitPrice, Discount, TotalAmount, TaxAmount) 
SELECT
    d.DateID,   
    c.CustomerID,  
    p.ProductID,  
    e.EmployeeID,  
    cat.CategoryID,  
    s.ShipperID,  
    sup.SupplierID, 
    od.Quantity, 
    od.UnitPrice, 
    od.Discount,    
    (od.Quantity * od.UnitPrice - od.Discount) AS TotalAmount,
    (od.Quantity * od.UnitPrice - od.Discount) * 0.1 AS TaxAmount     
FROM staging_order_details od 
JOIN staging_orders o ON od.OrderID = o.OrderID 
JOIN staging_customers c ON o.CustomerID = c.CustomerID 
JOIN staging_products p ON od.ProductID = p.ProductID  
LEFT JOIN staging_employees e ON o.EmployeeID = e.EmployeeID 
 LEFT JOIN staging_categories cat ON p.CategoryID = cat.CategoryID 
 LEFT JOIN staging_shippers s ON o.ShipVia = s.ShipperID  
LEFT JOIN staging_suppliers sup ON p.SupplierID = sup.SupplierID
LEFT JOIN DimDate d ON o.OrderDate = d.Date;
6. After loading data into the fact and dimension tables, you should validate the data to ensure it is accurate and complete. This process typically involves: 

*Checking for data and referential integrity
*Verifying that the data in the fact and dimension tables aligns with the source data
*Ensuring that all records have been transferred correctly


Prepare Business Report Queries

Now that you have built the DWH, create scripts (SQLs) to cover the following business requirements:

1.Display average sales (total amount, net amount, tax; number of transactions), the rolling average for three months (January–February; January–February–March; February–March–April) per day (specifying the month and date range) across all product categories (selected category, list of categories) in geographical sections (regions, countries, states), in gender sections (men, women), by age group (0–18, 19–28, 28–45, 45–60, 60+), by income (0–20000, 20001–40000, 40001–60000, 60001–80000, 80001-100000). This involves querying the FactSales and DimDate tables.
2.Display the top (worst) five products by number of transactions, total sales, and tax (add category section). This involves querying the FactSales table.
3.Display the top (worst) five customers by number of transactions and purchase amount (add gender section, region, country, product categories, age group). This involves querying the FactSales table.
4.Display a sales chart (with the total amount of sales and the quantity of items sold) for the first week of each month. This involves querying the FactSales and DimDate tables.
5.Display a weekly sales report (with monthly totals) by product category (period: one year). This involves querying the FactSales, DimDate, and DimProduct tables.
6.Display the median monthly sales value by product category and country. This involves querying the FactSales, DimProduct, and DimCustomer tables and requires a more complex query or a custom function to calculate the median.
7.Display sales rankings by product category (with the best-selling categories at the top). This involves querying the FactSales and DimProduct tables.
