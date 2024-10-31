-- Drop tables if they already exist
DROP TABLE IF EXISTS northwind.FactSales CASCADE;
DROP TABLE IF EXISTS northwind.DimDate CASCADE;
DROP TABLE IF EXISTS northwind.DimCustomer CASCADE;
DROP TABLE IF EXISTS northwind.DimProduct CASCADE;
DROP TABLE IF EXISTS northwind.DimEmployee CASCADE;
DROP TABLE IF EXISTS northwind.DimCategory CASCADE;
DROP TABLE IF EXISTS northwind.DimShipper CASCADE;
DROP TABLE IF EXISTS northwind.DimSupplier CASCADE;

-- Create DimDate Table
CREATE TABLE northwind.DimDate (
    DateID SERIAL PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    WeekOfYear INT
);

-- Create DimCustomer Table
CREATE TABLE northwind.DimCustomer (
    CustomerID VARCHAR(5) PRIMARY KEY,
    CompanyName VARCHAR(40),
    ContactName VARCHAR(30),
    ContactTitle VARCHAR(30),
    Address VARCHAR(60),
    City VARCHAR(15),
    Region VARCHAR(15),
    PostalCode VARCHAR(10),
    Country VARCHAR(15),
    Phone VARCHAR(24)
);

-- Create DimProduct Table
CREATE TABLE northwind.DimProduct (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(40),
    SupplierID INT,  -- Temporarily remove foreign key
    CategoryID INT,  -- Temporarily remove foreign key
    QuantityPerUnit VARCHAR(20),
    UnitPrice NUMERIC(10, 2),
    UnitsInStock INT
);

-- Create DimEmployee Table
CREATE TABLE northwind.DimEmployee (
    EmployeeID SERIAL PRIMARY KEY,
    LastName VARCHAR(20),
    FirstName VARCHAR(10),
    Title VARCHAR(30),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(60),
    City VARCHAR(15),
    Region VARCHAR(15),
    PostalCode VARCHAR(10),
    Country VARCHAR(15),
    HomePhone VARCHAR(24),
    Extension VARCHAR(4)
);

-- Create DimCategory Table
CREATE TABLE northwind.DimCategory (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(15),
    Description TEXT
);

-- Create DimShipper Table
CREATE TABLE northwind.DimShipper (
    ShipperID SERIAL PRIMARY KEY,
    CompanyName VARCHAR(40),
    Phone VARCHAR(24)
);

-- Create DimSupplier Table
CREATE TABLE northwind.DimSupplier (
    SupplierID SERIAL PRIMARY KEY,
    CompanyName VARCHAR(40),
    ContactName VARCHAR(30),
    ContactTitle VARCHAR(30),
    Address VARCHAR(60),
    City VARCHAR(15),
    Region VARCHAR(15),
    PostalCode VARCHAR(10),
    Country VARCHAR(15),
    Phone VARCHAR(24)
);

-- Create FactSales Table
CREATE TABLE northwind.FactSales (
    SalesID SERIAL PRIMARY KEY,
    DateID INT,  -- Temporarily remove foreign key
    CustomerID VARCHAR(5),  -- Temporarily remove foreign key
    ProductID INT,  -- Temporarily remove foreign key
    EmployeeID INT,  -- Temporarily remove foreign key
    CategoryID INT,  -- Temporarily remove foreign key
    ShipperID INT,  -- Temporarily remove foreign key
    SupplierID INT,  -- Temporarily remove foreign key
    QuantitySold INT,
    UnitPrice NUMERIC(10, 2),
    Discount REAL,
    TotalAmount NUMERIC(10, 2),  -- Calculated as QuantitySold * UnitPrice - Discount
    TaxAmount NUMERIC(10, 2)      -- Example calculated field, such as 10% of TotalAmount
);

-- Add Foreign Key Constraints
ALTER TABLE northwind.DimProduct
ADD CONSTRAINT fk_supplier FOREIGN KEY (SupplierID) REFERENCES northwind.DimSupplier(SupplierID),
ADD CONSTRAINT fk_category FOREIGN KEY (CategoryID) REFERENCES northwind.DimCategory(CategoryID);

ALTER TABLE northwind.FactSales
ADD CONSTRAINT fk_date FOREIGN KEY (DateID) REFERENCES northwind.DimDate(DateID),
ADD CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES northwind.DimCustomer(CustomerID),
ADD CONSTRAINT fk_product FOREIGN KEY (ProductID) REFERENCES northwind.DimProduct(ProductID),
ADD CONSTRAINT fk_employee FOREIGN KEY (EmployeeID) REFERENCES northwind.DimEmployee(EmployeeID),
ADD CONSTRAINT fk_category_fact FOREIGN KEY (CategoryID) REFERENCES northwind.DimCategory(CategoryID),
ADD CONSTRAINT fk_shipper FOREIGN KEY (ShipperID) REFERENCES northwind.DimShipper(ShipperID),
ADD CONSTRAINT fk_supplier_fact FOREIGN KEY (SupplierID) REFERENCES northwind.DimSupplier(SupplierID);

