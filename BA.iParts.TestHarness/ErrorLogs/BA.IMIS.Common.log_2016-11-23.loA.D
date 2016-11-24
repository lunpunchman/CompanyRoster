2016-11-23 13:33:36.282 ERROR 5 BA.IMIS.Common.Shared - System.Data.SqlClient.SqlException (0x80131904): String or binary data would be truncated.
String or binary data would be truncated.
String or binary data would be truncated.
The statement has been terminated.
The statement has been terminated.
The statement has been terminated.
Cannot grant, deny, or revoke permissions to sa, dbo, entity owner, information_schema, sys, or yourself.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at BA.IMIS.Common.Data.SQL.ExecuteSPNonQuery(SqlCommand cmd, String DBConn) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SQL.cs:line 47
   at BA.iParts.CompanyRoster.CompanyRosterShared.DeleteFromRoster(String IMIS_ID, String SentByLoginID) in C:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\iParts\BACustom\CompanyRoster\BA.iParts.CompanyRoster\Classes\CompanyRoster.cs:line 393
ClientConnectionId:dfefd2d3-21bb-4ae9-a575-4bb67dc1267d
Error Number:8152,State:14,Class:16
