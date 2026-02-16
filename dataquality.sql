/* ==========================================================
   File: 03_data_quality.sql
   Project: Sales KPI Dashboard
   Database: AdventureWorks2022
   Author: Bijaya Ram Shrestha

   Purpose:
       Perform data quality checks before KPI analysis.
       Validates completeness, uniqueness, and data integrity.
   ========================================================== */


-- ==========================================================
-- 1. Missing Value Checks
-- ==========================================================

-- Check for missing OrderDate
SELECT 
    COUNT(*) AS NullOrderDate
FROM Sales.SalesOrderHeader
WHERE OrderDate IS NULL;


-- Check for missing ProductID
SELECT 
    COUNT(*) AS NullProductID
FROM Sales.SalesOrderDetail
WHERE ProductID IS NULL;



-- ==========================================================
-- 2. Duplicate Record Check
-- ==========================================================

-- Check for duplicate SalesOrderDetail rows
SELECT 
    SalesOrderID,
    SalesOrderDetailID,
    COUNT(*) AS DuplicateCount
FROM Sales.SalesOrderDetail
GROUP BY 
    SalesOrderID,
    SalesOrderDetailID
HAVING COUNT(*) > 1;



-- ==========================================================
-- 3. Invalid / Negative Value Checks
-- ==========================================================

-- Check for invalid quantity or pricing values
SELECT 
    COUNT(*) AS InvalidLineItems
FROM Sales.SalesOrderDetail
WHERE 
    OrderQty <= 0
    OR UnitPrice < 0
    OR LineTotal < 0;
    