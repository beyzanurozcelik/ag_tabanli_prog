-- 20 yeni BusinessEntity 
DECLARE @i INT = 1;
WHILE @i <= 20
BEGIN
    INSERT INTO Person.BusinessEntity (rowguid, ModifiedDate)
    VALUES (NEWID(), GETDATE());
    SET @i += 1;
END;

-- Son 20 kayýt
SELECT TOP 20 BusinessEntityID 
INTO #NewEntityIDs
FROM Person.BusinessEntity 
ORDER BY BusinessEntityID DESC;



INSERT INTO Person.EmailAddress (BusinessEntityID, EmailAddress, rowguid, ModifiedDate)
SELECT 
    BusinessEntityID,
    CASE 
        WHEN number % 2 = 0 THEN 'invalid_email'
        WHEN number % 3 = 0 THEN NULL
        ELSE 'testemail@domain' -- eksik .com
    END,
    NEWID(),
    GETDATE()
FROM (
    SELECT BusinessEntityID, ROW_NUMBER() OVER (ORDER BY BusinessEntityID) AS number
    FROM #NewEntityIDs
) AS temp;

-- NULL veya boþ FirstName
SELECT * FROM Person.Person
WHERE FirstName IS NULL OR LTRIM(RTRIM(FirstName)) = '';

-- Geçersiz EmailAddress
SELECT * FROM Person.EmailAddress
WHERE EmailAddress IS NULL OR EmailAddress NOT LIKE '%@%.%';

DELETE FROM Person.EmailAddress
WHERE EmailAddress NOT LIKE '%_@_%._%';

DELETE FROM Person.Person
WHERE BusinessEntityID IN (
    SELECT BusinessEntityID FROM Person.EmailAddress
    WHERE EmailAddress NOT LIKE '%_@_%._%'
);

SELECT * FROM Person.Person
WHERE FirstName IS NULL OR LTRIM(RTRIM(FirstName)) = '';
SELECT * FROM Person.EmailAddress
WHERE EmailAddress NOT LIKE '%_@_%._%';


-- Örnek tablo ve veri
CREATE TABLE Orders (
    OrderID int,
    OrderDate varchar(50), -- farklý formatta tarih var
    Amount varchar(20),
    Currency varchar(3),
    CountryCode varchar(2)
);

INSERT INTO Orders VALUES
(101, '01/05/2025', '1000,50', 'EUR', 'DE'),
(102, '2025-05-02', '$1200.75', 'USD', 'US'),
(103, '5-3-2025', '900.00', 'USD', 'US'),
(104, '2025.05.04', '850,25', 'EUR', 'FR'),
(105, 'May 5 2025', '1500', 'GBP', 'GB');

-- Tarihleri ve amountlarý ayný formata çevirip orders'a ekleyelim
ALTER TABLE Orders ADD OrderDateStandard date NULL;
ALTER TABLE Orders ADD AmountStandard decimal(18,2) NULL;

UPDATE Orders
SET 
    OrderDateStandard = COALESCE(
        TRY_CONVERT(date, OrderDate, 103),
        TRY_CONVERT(date, OrderDate, 120),
        TRY_CAST(OrderDate AS date)
    ),
    AmountStandard = CAST(REPLACE(REPLACE(Amount, '$', ''), ',', '.') AS decimal(18,2));

SELECT * FROM Orders

ALTER TABLE Orders
DROP COLUMN OrderDate 

ALTER TABLE Orders
DROP COLUMN Amount

SELECT * FROM Orders

SELECT COUNT(*) AS NullCount FROM Person.Person WHERE FirstName IS NULL;
