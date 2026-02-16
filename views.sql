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

CREATE OR ALTER VIEW dbo.vw_sales_line AS

SELECT
    h.SalesOrderID,          -- Unique order identifier
    h.OrderDate,             -- Date of the order
    h.CustomerID,            -- Customer placing the order
    h.TerritoryID,           -- Geographic sales territory
    h.OnlineOrderFlag,       -- 1 = Online, 0 = Offline

    d.SalesOrderDetailID,    -- Unique line item identifier
    d.ProductID,             -- Product sold
    d.OrderQty,              -- Quantity sold
    d.UnitPrice,             -- Price per unit
    d.UnitPriceDiscount,     -- Discount applied
    d.LineTotal              -- Revenue for this line item

FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID;
