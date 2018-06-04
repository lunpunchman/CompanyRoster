2016-12-01 08:58:55.142 ERROR 5 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:00:59.9989987. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9344547. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
   at System.Net.Sockets.Socket.Receive(Byte[] buffer, Int32 offset, Int32 size, SocketFlags socketFlags)
   at System.ServiceModel.Channels.SocketConnection.ReadCore(Byte[] buffer, Int32 offset, Int32 size, TimeSpan timeout, Boolean closing)
   --- End of inner exception stack trace ---
   at System.ServiceModel.Channels.SocketConnection.ReadCore(Byte[] buffer, Int32 offset, Int32 size, TimeSpan timeout, Boolean closing)
   at System.ServiceModel.Channels.SocketConnection.Read(Byte[] buffer, Int32 offset, Int32 size, TimeSpan timeout)
   at System.ServiceModel.Channels.DelegatingConnection.Read(Byte[] buffer, Int32 offset, Int32 size, TimeSpan timeout)
   at System.ServiceModel.Channels.ConnectionUpgradeHelper.InitiateUpgrade(StreamUpgradeInitiator upgradeInitiator, IConnection& connection, ClientFramingDecoder decoder, IDefaultCommunicationTimeouts defaultTimeouts, TimeoutHelper& timeoutHelper)
   at System.ServiceModel.Channels.ClientFramingDuplexSessionChannel.SendPreamble(IConnection connection, ArraySegment`1 preamble, TimeoutHelper& timeoutHelper)
   at System.ServiceModel.Channels.ClientFramingDuplexSessionChannel.DuplexConnectionPoolHelper.AcceptPooledConnection(IConnection connection, TimeoutHelper& timeoutHelper)
   at System.ServiceModel.Channels.ConnectionPoolHelper.EstablishConnection(TimeSpan timeout)
   at System.ServiceModel.Channels.ClientFramingDuplexSessionChannel.OnOpen(TimeSpan timeout)
   --- End of inner exception stack trace ---

Server stack trace: 
   at System.ServiceModel.Channels.ClientFramingDuplexSessionChannel.OnOpen(TimeSpan timeout)
   at System.ServiceModel.Channels.CommunicationObject.Open(TimeSpan timeout)
   at System.ServiceModel.Channels.SecurityChannelFactory`1.ClientSecurityChannel`1.OnOpen(TimeSpan timeout)
   at System.ServiceModel.Channels.CommunicationObject.Open(TimeSpan timeout)
   at System.ServiceModel.Channels.ServiceChannel.OnOpen(TimeSpan timeout)
   at System.ServiceModel.Channels.CommunicationObject.Open(TimeSpan timeout)
   at System.ServiceModel.Channels.CommunicationObject.Open()

Exception rethrown at [0]: 
   at System.Runtime.Remoting.Proxies.RealProxy.HandleReturnMessage(IMessage reqMsg, IMessage retMsg)
   at System.Runtime.Remoting.Proxies.RealProxy.PrivateInvoke(MessageData& msgData, Int32 type)
   at System.ServiceModel.ICommunicationObject.Open()
   at Asi.Soa.ClientServices.ExceptionHandlingProxyBase`1.Open()
   at Asi.Soa.ClientServices.EntityManager.GetClient()
   at Asi.Soa.ClientServices.EntityManager..ctor(Uri baseEndpointUri, String userName, String password, EndpointType endpointType)
   at BA.IMIS.Common.Shared.get_EntityMgr() in C:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 92
2016-12-01 09:02:59.047 ERROR 5 BA.IMIS.Common.Shared - System.ServiceModel.FaultException`1[Asi.Soa.Core.DataContracts.Faults.ServiceFault]: Service Error: 

An error has occurred while consuming this service. Please contact your administrator for more information. Error ID: 0aaa4f2e-7d2c-45c2-ae57-3d81c3b996d3
Timestamp: 12/1/2016 9:02:58 AM
Message Id: 0aaa4f2e-7d2c-45c2-ae57-3d81c3b996d3
An exception of type 'SqlException' occurred
Type: SqlException
Message: The multi-part identifier ".GroupTypeKey" could not be bound.
Source: .Net SqlClient Data Provider
Stack Trace:    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlC... (Fault Detail is equal to Asi.Soa.Core.DataContracts.Faults.ServiceFault).
