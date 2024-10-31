CREATE TABLE staging_orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID VARCHAR(5),
    EmployeeID INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipVia INT,
    Freight NUMERIC(10, 2)
);

CREATE TABLE staging_order_details (
    OrderID INT,
    ProductID INT,
    UnitPrice NUMERIC(10, 2),
    Quantity INT,
    Discount REAL,
    PRIMARY KEY (OrderID, ProductID)
);

CREATE TABLE staging_products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(40),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(20),
    UnitPrice NUMERIC(10, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BOOLEAN
);

CREATE TABLE staging_customers (
    CustomerID VARCHAR(5) PRIMARY KEY,
    CompanyName VARCHAR(40),
    ContactName VARCHAR(30),
    ContactTitle VARCHAR(30),
    Address VARCHAR(60),
    City VARCHAR(15),
    Region VARCHAR(15),
    PostalCode VARCHAR(10),
    Country VARCHAR(15),
    Phone VARCHAR(24),
    Fax VARCHAR(24)
);

CREATE TABLE staging_employees (
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

CREATE TABLE staging_categories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(15),
    Description TEXT
);

CREATE TABLE staging_shippers (
    ShipperID SERIAL PRIMARY KEY,
    CompanyName VARCHAR(40),
    Phone VARCHAR(24)
);

CREATE TABLE staging_suppliers (
    SupplierID SERIAL PRIMARY KEY,
    CompanyName VARCHAR(40),
    ContactName VARCHAR(30),
    ContactTitle VARCHAR(30),
    Address VARCHAR(60),
    City VARCHAR(15),
    Region VARCHAR(15),
    PostalCode VARCHAR(10),
    Country VARCHAR(15),
    Phone VARCHAR(24),
    Fax VARCHAR(24),
    HomePage TEXT
);
