USE AdventureWorks2022;
GO

CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_OrderDate
ON Sales.SalesOrderHeader (OrderDate, CustomerID);

CREATE NONCLUSTERED INDEX IX_Product_Color
ON Production.Product (Color);

CREATE NONCLUSTERED INDEX IX_Customer_PersonID
ON Sales.Customer (PersonID);

CREATE NONCLUSTERED INDEX IX_Sales_SalesOrderDetails
ON Sales.SalesOrderDetail (ProductID)
INCLUDE (LineTotal, UnitPrice);


DROP INDEX IX_SalesOrderHeader_OrderDate ON Sales.SalesOrderHeader;
DROP INDEX IX_Product_Color ON Production.Product;
DROP INDEX IX_Customer_PersonID ON Sales.Customer;
DROP INDEX IX_Sales_SalesOrderDetails ON Sales.SalesOrderDetail;


