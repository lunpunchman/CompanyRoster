2016-11-26 22:16:29.290 ERROR 5 BA.IMIS.Common.Shared - System.ServiceModel.FaultException`1[Asi.Soa.Core.DataContracts.Faults.ServiceFault]: Service Error: 

An error has occurred while consuming this service. Please contact your administrator for more information. Error ID: 62f5f4a0-418b-44a5-a3a0-02a67d84a307
Timestamp: 11/26/2016 10:16:29 PM
Message Id: 62f5f4a0-418b-44a5-a3a0-02a67d84a307
An exception of type 'SqlException' occurred
Type: SqlException
Message: The multi-part identifier ".MemberContactKey" could not be bound.
The multi-part identifier ".GroupTypeKey" could not be bound.
Source: .Net SqlClient Data Provider
Stack Trace:    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data... (Fault Detail is equal to Asi.Soa.Core.DataContracts.Faults.ServiceFault).
