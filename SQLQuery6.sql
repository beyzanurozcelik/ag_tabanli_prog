USE [AdventureWorks2022]; 
GO

CREATE ROLE VeriYoneticiRolu;

CREATE USER beyzanur FOR LOGIN [BEYZANUR\bnuro];

ALTER ROLE VeriYonRol ADD MEMBER beyzanur;

-- AdventureWorks2022 üzerinde sadece SELECT ve BACKUP izni ver
USE AdventureWorks2022;
GRANT SELECT TO VeriYoneticiRolu;


SELECT 
    r.name AS RoleName,
    m.name AS MemberName
FROM sys.database_role_members AS drm
JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id;


SELECT 
    dp.name AS PrincipalName,
    perm.permission_name,
    perm.state_desc,
    perm.class_desc,
    OBJECT_NAME(perm.major_id) AS ObjectName
FROM sys.database_permissions perm
JOIN sys.database_principals dp ON perm.grantee_principal_id = dp.principal_id;



EXEC sp_droprolemember 'VeriYonRol', 'beyzanur';
drop role VeriYonRol;

CREATE TABLE Sales.SalesOrderNotes (
    SalesOrderNoteID INT PRIMARY KEY,
    SalesOrderID INT,
    NoteText NVARCHAR(500),
    DateAdded DATETIME
);

INSERT INTO Sales.SalesOrderNotes (SalesOrderNoteID, SalesOrderID, NoteText, DateAdded)
VALUES (1, 10001, 'Customer requested special packaging.', GETDATE());

