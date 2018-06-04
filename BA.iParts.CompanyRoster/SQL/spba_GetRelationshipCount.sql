USE [IMIS20]
GO
/****** Object:  StoredProcedure [dbo].[spba_GetRelationshipCount]    Script Date: 8/8/2017 5:32:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spba_GetRelationshipCount]
@ID varchar(10),
@RELATION_TYPE varchar(10)=NULL
AS
IF @RELATION_TYPE IS NULL
	SELECT CoAdmin, Invoice, [Owner]
	FROM (SELECT ID, COUNT(*) CoAdmin FROM Relationship WHERE ID=@ID AND RELATION_TYPE='_ORG-ADMIN' GROUP BY ID) coadmin
	JOIN (SELECT ID, COUNT(*) Invoice FROM Relationship WHERE ID=@ID AND RELATION_TYPE='INVOICE' GROUP BY ID) invoice ON coadmin.ID=invoice.ID
	JOIN (SELECT ID, COUNT(*) [Owner] FROM Relationship WHERE ID=@ID AND RELATION_TYPE='OWNER' GROUP BY ID) own ON coadmin.ID=own.ID
	--SELECT COUNT(*) FROM Relationship
	--WHERE ID=900045200 AND RELATION_TYPE='_ORG-ADMIN'
ELSE
	SELECT COUNT(*) FROM Relationship
	WHERE ID=@ID AND RELATION_TYPE=@RELATION_TYPE

grant exec on spba_GetRelationshipCount to imis_prod_ro