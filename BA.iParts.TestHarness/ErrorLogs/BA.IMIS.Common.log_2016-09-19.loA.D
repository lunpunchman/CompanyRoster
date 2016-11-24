2016-09-19 11:10:13.316 ERROR 6 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:00:59.9994996. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9964973. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 86
2016-09-19 11:10:13.349 ERROR 6 BA.IMIS.Common.Shared - System.NullReferenceException: Object reference not set to an instance of an object.
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.FindEmailByID(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 207
2016-09-19 11:11:13.381 ERROR 6 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:01:00. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9979994. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 86
2016-09-19 11:11:13.391 ERROR 6 BA.IMIS.Common.Shared - System.NullReferenceException: Object reference not set to an instance of an object.
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.GetParentCompany(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 160
2016-09-19 15:24:52.322 ERROR 5 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:00:59.9994987. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9964993. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 86
2016-09-19 15:24:52.344 ERROR 5 BA.IMIS.Common.Shared - System.NullReferenceException: Object reference not set to an instance of an object.
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.FindEmailByID(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 207
2016-09-19 17:11:14.984 ERROR 6 BA.IMIS.Common.Shared - System.TimeoutException: The open operation did not complete within the allotted timeout of 00:00:59.9990003. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The socket transfer timed out after 00:00:59.9964986. You have exceeded the timeout set on your binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond
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
   at BA.IMIS.Common.Shared.get_EntityMgr() in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 86
2016-09-19 17:11:15.005 ERROR 6 BA.IMIS.Common.Shared - System.NullReferenceException: Object reference not set to an instance of an object.
   at BA.IMIS.Common.Data.SOA.GetIQAResults(String QueryName, String[] Parameters) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Data\SOA.cs:line 27
   at BA.IMIS.Common.Shared.FindEmailByID(String IMIS_ID) in c:\Users\mike.BA\Documents\Visual Studio 2015\Projects\iMIS Projects\BA.IMIS.Common\Common.cs:line 207
