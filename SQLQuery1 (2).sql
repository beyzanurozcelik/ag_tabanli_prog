USE AdventureWorks2022;
GO
CREATE USER user1 FOR LOGIN user1;

-- Tüm tablolarda SELECT izni ver
GRANT SELECT TO user1;
-- Kullanýcýnýn veri deðiþtirme yetkisini engelle
DENY INSERT TO user1;
DENY UPDATE TO user1;
DENY DELETE TO user1;


SELECT 
    dp.name AS PrincipalName,
    perm.permission_name,
    perm.state_desc,
    perm.class_desc,
    OBJECT_NAME(perm.major_id) AS ObjectName
FROM sys.database_permissions perm
JOIN sys.database_principals dp ON perm.grantee_principal_id = dp.principal_id;


USE AdventureWorks2022;
GO
SELECT * FROM HumanResources.Employee;
-- reportUser oturumunda çalýþtýrýlan sorgu
DELETE FROM HumanResources.Employee WHERE NationalIDNumber = 295847284;

-- 1. Sertifika ve master key oluþtur
USE master;
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '123';
GO
CREATE CERTIFICATE TDECert WITH SUBJECT = 'TDE Sertifikasý';
GO

-- 2. Veritabanýna encryption anahtarý oluþtur
USE AdventureWorks2022;
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TDECert;
GO

-- 3. Þifrelemeyi baþlat
ALTER DATABASE AdventureWorks2022 SET ENCRYPTION ON;
