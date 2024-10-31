-- Load data into staging tables

-- Customers
INSERT INTO northwind.staging_customers 
SELECT * FROM northwind.customers;

-- Orders
INSERT INTO northwind.staging_orders 
SELECT * FROM northwind.orders;

-- Order Details
INSERT INTO northwind.staging_order_details 
SELECT * FROM northwind.order_details;

-- Products
INSERT INTO northwind.staging_products 
SELECT * FROM northwind.products;

-- Employees
INSERT INTO northwind.staging_employees 
SELECT * FROM northwind.employees;

-- Categories
INSERT INTO northwind.staging_categories 
SELECT * FROM northwind.categories;

-- Shippers
INSERT INTO northwind.staging_shippers 
SELECT * FROM northwind.shippers;

-- Suppliers
INSERT INTO northwind.staging_suppliers 
SELECT * FROM northwind.suppliers;



INSERT INTO northwind.DimCustomer (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone) 
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone 
FROM northwind.staging_customers;


INSERT INTO northwind.DimProduct (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock) 
SELECT ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock 
FROM northwind.staging_products;

INSERT INTO northwind.DimEmployee (EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension) 
SELECT EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension 
FROM northwind.staging_employees;



INSERT INTO northwind.DimCategory (CategoryID, CategoryName, Description) 
SELECT CategoryID, CategoryName, Description 
FROM northwind.staging_categories;



INSERT INTO northwind.DimShipper (ShipperID, CompanyName, Phone) 
SELECT ShipperID, CompanyName, Phone 
FROM northwind.staging_shippers;


INSERT INTO northwind.DimSupplier (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone) 
SELECT SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone 
FROM northwind.staging_suppliers;


INSERT INTO northwind.FactSales (DateID, CustomerID, ProductID, EmployeeID, CategoryID, ShipperID, SupplierID, QuantitySold, UnitPrice, Discount, TotalAmount, TaxAmount) 
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
FROM northwind.staging_order_details od 
JOIN northwind.staging_orders o ON od.OrderID = o.OrderID 
JOIN northwind.staging_customers c ON o.CustomerID = c.CustomerID 
JOIN northwind.staging_products p ON od.ProductID = p.ProductID  
LEFT JOIN northwind.staging_employees e ON o.EmployeeID = e.EmployeeID 
LEFT JOIN northwind.staging_categories cat ON p.CategoryID = cat.CategoryID 
LEFT JOIN northwind.staging_shippers s ON o.ShipVia = s.ShipperID  
LEFT JOIN northwind.staging_suppliers sup ON p.SupplierID = sup.SupplierID
LEFT JOIN northwind.DimDate d ON o.OrderDate = d.Date;







