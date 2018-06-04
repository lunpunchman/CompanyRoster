USE [IMIS20]
GO
/****** Object:  StoredProcedure [dbo].[spba_GetCompanyRelationships]    Script Date: 8/11/2017 3:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spba_GetCompanyRelationships]
@ID varchar(10)
AS
	SELECT RELATION_TYPE, TARGET_ID AS EMPID FROM Relationship
	WHERE ID=@ID
grant exec on spba_GetCompanyRelationships to imis_prod_ro