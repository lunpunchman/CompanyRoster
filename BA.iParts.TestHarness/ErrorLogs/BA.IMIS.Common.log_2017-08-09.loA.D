2017-08-09 11:18:53,291={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:20:56,813={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:23:18,963={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:23:31,750={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:27:40,802={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:28:07,835={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:28:31,211={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:31:44,335={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:32:12,318={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:39:50,886={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:40:10,999={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Data.SqlClient.SqlException (0x80131904): Execution Timeout Expired.  The timeout period elapsed prior to completion of the operation or the server is not responding. ---> System.ComponentModel.Win32Exception (0x80004005): The wait operation timed out
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at BA.IMIS.Common.Data.SQL.ExecuteSPNonQuery(SqlCommand cmd, String DBConn) in C:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SQL.cs:line 47
   at BA.iParts.CompanyRoster.CompanyRosterShared.DeleteFromRoster(String IMIS_ID, String SentByLoginID) in C:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\iParts\BACustom\CompanyRoster\BA.iParts.CompanyRoster\Classes\CompanyRoster.cs:line 407
ClientConnectionId:0361244c-11bc-4830-95da-5602dff9515d
Error Number:-2,State:0,Class:11
2017-08-09 11:48:23,431={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:54:57,306={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 11:55:07,917={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 12:12:36,865={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 13:28:29,382={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:08:43,549={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:20:19,814={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:21:51,216={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:25:19,311={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:25:49,102={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:30:22,354={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:30:46,019={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:30:59,897={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Data.SqlClient.SqlException (0x80131904): Could not find stored procedure 'spba_GetAllRelationships'.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataTable[] dataTables, Int32 startRecord, Int32 maxRecords, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataTable dataTable)
   at BA.IMIS.Common.Data.SQL.ExecuteSPTable(SqlCommand cmd, String DBConn) in C:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SQL.cs:line 32
   at BA.iParts.CompanyRoster.CompanyRosterShared.GetAllRelationships(String IMIS_ID) in C:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\iParts\BACustom\CompanyRoster\BA.iParts.CompanyRoster\Classes\CompanyRoster.cs:line 457
ClientConnectionId:e7256f4d-20e7-487f-b233-a2ace2b7c03d
Error Number:2812,State:62,Class:16
2017-08-09 14:33:12,933={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:33:19,989={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:33:31,371={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Data.SqlClient.SqlException (0x80131904): Could not find stored procedure 'spba_GetAllRelationships'.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataTable[] dataTables, Int32 startRecord, Int32 maxRecords, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataTable dataTable)
   at BA.IMIS.Common.Data.SQL.ExecuteSPTable(SqlCommand cmd, String DBConn) in C:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SQL.cs:line 32
   at BA.iParts.CompanyRoster.CompanyRosterShared.GetAllRelationships(String IMIS_ID) in C:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\iParts\BACustom\CompanyRoster\BA.iParts.CompanyRoster\Classes\CompanyRoster.cs:line 457
ClientConnectionId:22419df6-4594-45ea-84f9-bfaf6067c063
Error Number:2812,State:62,Class:16
2017-08-09 14:38:28,879={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:40:55,532={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
2017-08-09 14:55:34,376={ABSOLUTE} [BA.IMIS.Common.Shared] ERROR - System.Exception: Hello World
