2016-11-22 08:35:19.163 ERROR 5 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:00:59.9989995. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9714808. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 92
2016-11-22 14:07:20.289 ERROR 6 BA.IMIS.Common.Shared - System.ServiceModel.FaultException`1[Asi.Soa.Core.DataContracts.Faults.ServiceFault]: Service Error: 

An error has occurred while consuming this service. Please contact your administrator for more information. Error ID: 9eb14707-e394-4b8a-9776-56f55c6abe66
Timestamp: 11/22/2016 2:07:20 PM
Message Id: 9eb14707-e394-4b8a-9776-56f55c6abe66
An exception of type 'SqlException' occurred
Type: SqlException
Message: The multi-part identifier ".GroupTypeKey" could not be bound.
Source: .Net SqlClient Data Provider
Stack Trace:    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.Sql... (Fault Detail is equal to Asi.Soa.Core.DataContracts.Faults.ServiceFault).
2016-11-22 21:02:42.110 ERROR 6 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:01:00. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9224478. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 108
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.FindEmailByID(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 232
2016-11-22 21:04:42.314 ERROR 6 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:01:00. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9029334. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 108
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.GetParentCompany(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 183
2016-11-22 21:06:50.066 ERROR 9 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:00:59.9995029. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9342238. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 108
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.FindEmailByID(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 232
2016-11-22 21:10:25.498 ERROR 5 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:01:00. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9299053. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 108
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.FindEmailByID(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 232
2016-11-22 21:12:25.691 ERROR 5 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:00:59.9994996. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9331449. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 108
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.GetParentCompany(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 183
2016-11-22 21:15:13.349 ERROR 5 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:01:00. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9180612. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 108
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.FindEmailByID(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 232
2016-11-22 21:16:17.785 ERROR 5 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:01:00. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9341638. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 92
