USE master;
GO

ALTER DATABASE AdventureWorks2022
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE AdventureWorks2022;
GO

RESTORE DATABASE AdventureWorks2022
FROM DISK = 'C:\Backups\AdventureWorks_Full_Backup_20250423.bak'
WITH NORECOVERY, REPLACE;

RESTORE DATABASE AdventureWorks2022
FROM DISK = 'C:\Backups\AdventureWorks_Diff_Backup_20250424_210001.bak'
WITH NORECOVERY;

RESTORE DATABASE AdventureWorks2022
FROM DISK = 'C:\Backups\AdventureWorks_Log_Backup_20250424_210001.bak'
WITH NORECOVERY;

RESTORE DATABASE AdventureWorks2022
FROM DISK = 'C:\Backups\AdventureWorks_Log_Backup_20250424_220001.bak'
WITH RECOVERY;


select * from msdb.dbo.BackupJobLog;