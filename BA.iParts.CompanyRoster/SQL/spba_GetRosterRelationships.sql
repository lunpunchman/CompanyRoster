ALTER PROCEDURE [dbo].[spba_GetRosterRelationships]
@ID varchar(10),
@CO_ID varchar(10)
AS
SELECT DESCRIPTION, t.RELATION_TYPE, CASE WHEN ID IS NULL THEN 0 ELSE 1 END AS IsRole
FROM Relationship_Types t
LEFT JOIN Relationship r ON t.RELATION_TYPE=r.RELATION_TYPE AND TARGET_ID=@ID AND ID=@CO_ID
WHERE t.RELATION_TYPE IN ('CULINARY','_ORG-ADMIN','BREW','GABF','GUILD','INVOICE','MARKET','OWNER','SOCIAL','MEDIA')
--Culinary, comp admin, Ad, Brew, gabf, guild, invoice, maket, owner, social

GRANT EXECUTE ON spba_GetRosterRelationships TO iMIS_Prod_RO

