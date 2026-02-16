/* ==========================================================
   File: 02_kpis.sql
   Project: Sales KPI Dashboard
   Database: AdventureWorks2022
   Author: Bijaya Ram Shrestha
   Description:
       Core Sales Performance KPIs for executive dashboard
   ========================================================== */


/* ==========================================================
   KPI 1: Total Revenue
   ----------------------------------------------------------
   Calculates overall revenue across all sales order lines.
   ========================================================== */

SELECT 
    SUM(LineTotal) AS TotalRevenue
FROM dbo.vw_sales_line;



/* ==========================================================
   KPI 2: Monthly Revenue Trend
   ----------------------------------------------------------
   Aggregates revenue by month to support trend analysis.
   ========================================================== */

SELECT
    DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS MonthStart,
    SUM(LineTotal) AS Revenue
FROM dbo.vw_sales_line
GROUP BY DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1)
ORDER BY MonthStart;



/* ==========================================================
   KPI 3: Total Orders & Average Order Value (AOV)
   ----------------------------------------------------------
   Step 1: Calculate revenue per order
   Step 2: Compute average order value
   ========================================================== */

WITH order_totals AS (
    SELECT 
        SalesOrderID,
        SUM(LineTotal) AS OrderRevenue
    FROM dbo.vw_sales_line
    GROUP BY SalesOrderID
)

SELECT
    COUNT(*) AS Orders,
    AVG(OrderRevenue) AS AvgOrderValue
FROM order_totals;



/* ==========================================================
   KPI 4: Top 10 Products by Revenue
   ----------------------------------------------------------
   Identifies highest revenue generating products.
   ========================================================== */

SELECT TOP 10
    p.Name AS ProductName,
    SUM(v.LineTotal) AS Revenue
FROM dbo.vw_sales_line v
JOIN Production.Product p 
    ON v.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY Revenue DESC;



/* ==========================================================
   KPI 5: Online vs Offline Revenue Split
   ----------------------------------------------------------
   Evaluates digital channel contribution.
   OnlineOrderFlag:
       1 = Online
       0 = Offline
   ========================================================== */

SELECT
    OnlineOrderFlag,
    SUM(LineTotal) AS Revenue,
    COUNT(DISTINCT SalesOrderID) AS Orders
FROM dbo.vw_sales_line
GROUP BY OnlineOrderFlag;



/* ==========================================================
   KPI 6: Revenue by Territory
   ----------------------------------------------------------
   Shows geographic revenue performance.
   ========================================================== */

SELECT
    t.Name AS TerritoryName,
    t.CountryRegionCode,
    SUM(v.LineTotal) AS Revenue
FROM dbo.vw_sales_line v
LEFT JOIN Sales.SalesTerritory t 
    ON v.TerritoryID = t.TerritoryID
GROUP BY 
    t.Name, 
    t.CountryRegionCode
ORDER BY Revenue DESC;
