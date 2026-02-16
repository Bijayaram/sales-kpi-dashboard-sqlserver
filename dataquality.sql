-- missing datacheck
-- check for missing order date
SELECT COUNT(*) AS NullOrderDate
FROM Sales.SalesOrderHeader
WHERE OrderDate IS NULL;
-- check for missing product id
SELECT COUNT(*) AS NullProductID
FROM Sales.SalesOrderDetail
WHERE ProductID IS NULL;
-- check for duplicate
SELECT SalesOrderID, SalesOrderDetailID, COUNT(*) AS Cnt
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID, SalesOrderDetailID
HAVING COUNT(*) > 1;
-- check for negative values
SELECT COUNT(*) AS BadLines
FROM Sales.SalesOrderDetail
WHERE OrderQty <= 0 OR UnitPrice < 0 OR LineTotal < 0;

