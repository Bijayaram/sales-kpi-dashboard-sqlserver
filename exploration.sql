/* ==========================================================
   File: 00_exploration.sql
   Project: Sales KPI Dashboard
   Database: AdventureWorks2022
   Author: Bijaya Ram Shrestha

   Purpose:
       Initial database exploration to understand:
       - Database context
       - Available schemas
       - Sales-related tables
       - Data volume
       - Date range
       - Table relationships
   ========================================================== */


-- ==========================================================
-- 1. Confirm Current Database
-- ==========================================================

SELECT DB_NAME() AS CurrentDatabase;



-- ==========================================================
-- 2. List Available Schemas
-- ==========================================================

SELECT DISTINCT TABLE_SCHEMA
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_SCHEMA;



-- ==========================================================
-- 3. List Tables in the Sales Schema
-- ==========================================================

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
  AND TABLE_SCHEMA = 'Sales'
ORDER BY TABLE_NAME;



-- ==========================================================
-- 4. Inspect Key Sales Tables (Sample Data)
-- ==========================================================

-- Sales Order Header (Order-level information)
SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

-- Sales Order Detail (Line-item information)
SELECT TOP 10 *
FROM Sales.SalesOrderDetail;



-- ==========================================================
-- 5. Understand Dataset Size
-- ==========================================================

-- Total number of orders
SELECT COUNT(*) AS Orders
FROM Sales.SalesOrderHeader;

-- Total number of order line items
SELECT COUNT(*) AS OrderLines
FROM Sales.SalesOrderDetail;



-- ==========================================================
-- 6. Check Date Range of Sales Data
-- ==========================================================

SELECT 
    MIN(OrderDate) AS FirstOrder,
    MAX(OrderDate) AS LastOrder
FROM Sales.SalesOrderHeader;



-- ==========================================================
-- 7. Validate Relationship Between Header and Detail
-- ==========================================================

SELECT TOP 10
    h.SalesOrderID,
    h.OrderDate,
    d.ProductID,
    d.OrderQty,
    d.LineTotal
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID;



-- ==========================================================
-- 8. Inspect Product Table
-- ==========================================================

SELECT TOP 10
    ProductID,
    Name
FROM Production.Product;



-- ==========================================================
-- 9. Join Product Information to Sales
-- ==========================================================

SELECT TOP 10
    h.SalesOrderID,
    h.OrderDate,
    p.Name AS ProductName,
    d.OrderQty,
    d.LineTotal
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d 
    ON h.SalesOrderID = d.SalesOrderID
JOIN Production.Product p      
    ON d.ProductID = p.ProductID;
