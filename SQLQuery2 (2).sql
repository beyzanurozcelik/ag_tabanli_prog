-- Mirror Server'da:
drop endpoint Mirroring
CREATE ENDPOINT Mirroring
STATE = STARTED
AS TCP (LISTENER_PORT = 5024)
FOR DATABASE_MIRRORING (
    ROLE = PARTNER
);

RESTORE DATABASE AdventureWorks2022
FROM DISK = 'C:\Backups\TestDB.bak'
WITH MOVE 'AdventureWorks2022' TO 'C:\SQLData\TestDB.mdf',
     MOVE 'AdventureWorks2022_log' TO 'C:\SQLData\TestDB_log.ldf',
     NORECOVERY, REPLACE;

ALTER DATABASE AdventureWorks2022
SET PARTNER = 'TCP://MSSQLServer:5022';


-- Log dosyasýný NORECOVERY ile restore et
RESTORE LOG [TestDB] FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AdventureWorks2022_log.ldf' WITH NORECOVERY;

RESTORE FILELISTONLY
FROM DISK = 'C:\Backups\TestDB.bak';

