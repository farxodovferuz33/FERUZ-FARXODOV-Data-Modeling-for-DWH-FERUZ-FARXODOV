-- Drop staging tables if they exist
DROP TABLE IF EXISTS northwind.staging_orders;
DROP TABLE IF EXISTS northwind.staging_order_details;
DROP TABLE IF EXISTS northwind.staging_products;
DROP TABLE IF EXISTS northwind.staging_customers;
DROP TABLE IF EXISTS northwind.staging_employees;
DROP TABLE IF EXISTS northwind.staging_categories;
DROP TABLE IF EXISTS northwind.staging_shippers;
DROP TABLE IF EXISTS northwind.staging_suppliers;

-- Create staging tables

CREATE TABLE northwind.staging_orders AS TABLE northwind.orders WITH NO DATA;

CREATE TABLE northwind.staging_order_details AS TABLE northwind.order_details WITH NO DATA;

CREATE TABLE northwind.staging_products AS TABLE northwind.products WITH NO DATA;

CREATE TABLE northwind.staging_customers AS TABLE northwind.customers WITH NO DATA;

CREATE TABLE northwind.staging_employees AS TABLE northwind.employees WITH NO DATA;

CREATE TABLE northwind.staging_categories AS TABLE northwind.categories WITH NO DATA;

CREATE TABLE northwind.staging_shippers AS TABLE northwind.shippers WITH NO DATA;

CREATE TABLE northwind.staging_suppliers AS TABLE northwind.suppliers WITH NO DATA;
