/*  EDGE_SYNC_USER login reset script.
*   
*   Before running this script, set the correct database.
*/

--USE OMATESQL  --or enter the correct database here
PRINT '******************************************';
PRINT 'EDGE_SYNC_USER login create/reset script.';
PRINT '  Begin: ' + + CAST(GETDATE() AS varchar);
PRINT '  Current Database is ' + DB_NAME() + '.';
PRINT '******************************************';
PRINT '';

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'EDGE_SYNC_USER')
  BEGIN
    PRINT 'Found existing database user.  Dropping user...';
	DROP USER EDGE_SYNC_USER;
	PRINT '  --Complete.';
  END

IF EXISTS (SELECT loginname from master.dbo.syslogins where name = 'EDGE_SYNC_USER' )
  BEGIN
    PRINT 'Found existing login.  Dropping login...';
	DROP LOGIN EDGE_SYNC_USER;
	PRINT '  --Complete.';
  END
PRINT '';
PRINT 'Creating EDGE_SYNC_USER login...';
CREATE LOGIN EDGE_SYNC_USER
WITH PASSWORD = 'secretuniquepassword',
CHECK_POLICY = OFF,
CHECK_EXPIRATION = OFF;
PRINT '  --Complete.';

PRINT 'Creating EDGE_SYNC_USER database user.';
CREATE USER EDGE_SYNC_USER FOR LOGIN EDGE_SYNC_USER
PRINT '  --Complete.';
PRINT 'Assigning read permissions.';
EXEC sp_addrolemember N'db_datareader', N'EDGE_SYNC_USER'
PRINT '  --Complete.';
PRINT '';
PRINT '******************************************';
PRINT '  --Script Complete.';
PRINT '  End: ' + CAST(GETDATE() AS varchar);
PRINT '******************************************';
