SELECT 
    p.Name AS ProductName,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    soh.OrderDate,
    sod.OrderQty AS QuantityOrdered,
    sod.LineTotal AS SalesAmount,
    AVG(sod.UnitPrice) AS AveragePrice,
    (SELECT SUM(sod2.LineTotal) 
     FROM Sales.SalesOrderDetail sod2 
     WHERE sod2.ProductID = p.ProductID) AS TotalSalesForProduct,
    (SELECT COUNT(DISTINCT soh2.SalesOrderID) 
     FROM Sales.SalesOrderHeader soh2 
     WHERE soh2.CustomerID = soh.CustomerID) AS NumberOfOrders,
    DATEDIFF(DAY, soh.OrderDate, GETDATE()) AS DaysSinceOrder
FROM 
    Sales.SalesOrderHeader soh, 
    Sales.SalesOrderDetail sod, 
    Production.Product p, 
    Sales.Customer cust, 
    Person.Person c
WHERE 
    soh.SalesOrderID = sod.SalesOrderID
    AND sod.ProductID = p.ProductID
    AND soh.CustomerID = cust.CustomerID
    AND cust.PersonID = c.BusinessEntityID
    AND soh.OrderDate BETWEEN '2010-01-01' AND '2013-01-01'
    AND p.Color = 'Black'
    AND sod.UnitPrice > 50
GROUP BY 
    p.Name, 
    c.FirstName, 
    c.LastName, 
    soh.OrderDate, 
    sod.OrderQty, 
    sod.LineTotal, 
    p.ProductID, 
    soh.CustomerID
ORDER BY 
    TotalSalesForProduct DESC, 
    DaysSinceOrder ASC;
