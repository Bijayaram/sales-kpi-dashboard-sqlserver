
  -- total revenue
SELECT SUM(LineTotal) AS TotalRevenue
FROM dbo.vw_sales_line;
-- Monthly revuene trend
SELECT
  DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS MonthStart,
  SUM(LineTotal) AS Revenue
FROM dbo.vw_sales_line
GROUP BY DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1)
ORDER BY MonthStart;

