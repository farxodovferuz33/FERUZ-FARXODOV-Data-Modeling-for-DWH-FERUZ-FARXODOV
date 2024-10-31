-- Drop tables if they already exist
DROP TABLE IF EXISTS northwind.DimDate;
DROP TABLE IF EXISTS northwind.DimCustomer;
DROP TABLE IF EXISTS northwind.DimProduct;
DROP TABLE IF EXISTS northwind.DimEmployee;
DROP TABLE IF EXISTS northwind.DimCategory;
DROP TABLE IF EXISTS northwind.DimShipper;
DROP TABLE IF EXISTS northwind.DimSupplier;
DROP TABLE IF EXISTS northwind.FactSales;

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
    SupplierID INT REFERENCES northwind.DimSupplier(SupplierID),
    CategoryID INT REFERENCES northwind.DimCategory(CategoryID),
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
    DateID INT REFERENCES northwind.DimDate(DateID),
    CustomerID VARCHAR(5) REFERENCES northwind.DimCustomer(CustomerID),
    ProductID INT REFERENCES northwind.DimProduct(ProductID),
    EmployeeID INT REFERENCES northwind.DimEmployee(EmployeeID),
    CategoryID INT REFERENCES northwind.DimCategory(CategoryID),
    ShipperID INT REFERENCES northwind.DimShipper(ShipperID),
    SupplierID INT REFERENCES northwind.DimSupplier(SupplierID),
    QuantitySold INT,
    UnitPrice NUMERIC(10, 2),
    Discount REAL,
    TotalAmount NUMERIC(10, 2),  -- Calculated as QuantitySold * UnitPrice - Discount
    TaxAmount NUMERIC(10, 2)     -- Example calculated field, such as 10% of TotalAmount
);
