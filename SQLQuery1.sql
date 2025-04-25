SELECT 
    p.Name AS ProductName,
    SUM(sod.LineTotal) AS TotalSales,
    AVG(sod.UnitPrice) AS AvgPrice,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    soh.OrderDate
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product AS p ON sod.ProductID = p.ProductID
JOIN Sales.Customer AS cust ON soh.CustomerID = cust.CustomerID
JOIN Person.Person AS c ON cust.PersonID = c.BusinessEntityID
WHERE soh.OrderDate BETWEEN '2011-01-01' AND '2012-01-01'
  AND p.Color = 'Black'
GROUP BY p.Name, c.FirstName, c.LastName, soh.OrderDate
ORDER BY TotalSales DESC;
