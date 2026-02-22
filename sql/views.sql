/* ==========================================================
   File: 01_views.sql
   Project: Sales KPI Dashboard
   Database: AdventureWorks2022
   Author: Bijaya Ram Shrestha
   Description:
       Creates analytical base view combining 
       SalesOrderHeader and SalesOrderDetail.
       
       This view simplifies KPI analysis by providing
       one row per sales order line.
   ========================================================== */


-- ==========================================================
-- View: vw_sales_line
-- Purpose:
--     Combine order header and order detail into
--     a single analytical dataset for KPI calculations.
-- ==========================================================

ALTER VIEW dbo.vw_sales_line AS
SELECT
    h.SalesOrderID,
    h.OrderDate,
    h.CustomerID,
    h.TerritoryID,
    t.Name        AS TerritoryName,
    t.CountryRegionCode,
    t.[Group]     AS TerritoryGroup,

    d.SalesOrderDetailID,
    d.ProductID,
    p.Name        AS ProductName,
    d.OrderQty,
    d.UnitPrice,
    d.LineTotal,

    YEAR(h.OrderDate)  AS OrderYear,
    MONTH(h.OrderDate) AS OrderMonth
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID
LEFT JOIN Production.Product p
    ON d.ProductID = p.ProductID
LEFT JOIN Sales.SalesTerritory t
    ON h.TerritoryID = t.TerritoryID;
GO
