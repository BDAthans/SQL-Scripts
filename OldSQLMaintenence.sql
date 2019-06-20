--------------------------------------------------------------------------------------------------------------
-- SQL Maintenance Plan
-- Version 1.0
-------------------------------------------------------------------------------------------------------------------

-- >>>>>>>>>>>>>>>>>>>CHANGE THIS TO USE YOUR DATABASE
USE OMateSQL

-- find all the tables in the database
-- and rebuild all the indexes on each table
-- also run the database consistency checker on each table
DECLARE @TargetDatabase AS VARCHAR(50) 
DECLARE @FillFactor AS INT
DECLARE @TableName AS sysname
DECLARE @Command AS VARCHAR(200)
-- Set the table fill factor
SET @FillFactor = 80
PRINT 'REBUILDING ALL INDEXES AND RUNNING CHECK ON TABLES'
PRINT '-------------------------------------------------------------------------'
DECLARE reb_cursor  CURSOR
FOR
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'
OPEN reb_cursor
FETCH NEXT FROM reb_cursor INTO @TableName
WHILE @@FETCH_STATUS <> -1
BEGIN
	IF @@FETCH_STATUS <> -2
	BEGIN
		PRINT @TableName
		SET @Command = 'ALTER INDEX ALL ON [' + @TableName + '] REBUILD WITH (FILLFACTOR =' + CAST(@Fillfactor AS VARCHAR(10)) + ');'
		EXEC (@Command);
		SET @Command = 'DBCC CHECKTABLE ([' + @TableName + '])'
		EXEC (@Command);
	END
	FETCH NEXT FROM reb_cursor INTO @TableName
END
CLOSE reb_cursor
DEALLOCATE reb_cursor
PRINT '-------------------------------------------------------------------------'
GO

--SHRINK DATABASE
DECLARE @fileid as INT
DECLARE @Command AS VARCHAR(200)
PRINT 'SHRINKING ALL FILES'
PRINT '-------------------------------------------------------------------------'
DECLARE file_cursor  CURSOR
FOR
SELECT file_id FROM sys.database_files
OPEN file_cursor
FETCH NEXT FROM file_cursor INTO @fileid
WHILE @@FETCH_STATUS <> -1
BEGIN
	IF @@FETCH_STATUS <> -2
	BEGIN
		PRINT @fileid
		SET @Command = 'DBCC SHRINKFILE (' + CAST(@fileid AS VARCHAR(10)) + ')'
		EXEC (@Command);
	END
	FETCH NEXT FROM file_cursor INTO @fileid
END
CLOSE file_cursor
DEALLOCATE file_cursor
PRINT '-------------------------------------------------------------------------'
GO
 
