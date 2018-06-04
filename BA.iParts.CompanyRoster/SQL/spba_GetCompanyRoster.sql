ALTER PROC [dbo].[spba_GetCompanyRoster] (
	@IMIS_ID varchar(10)
)
AS BEGIN
	DECLARE @True bit, @False bit
	SET @True=1
	SET @False=0
	;WITH ChildContacts(ChildIMIS_ID, ChildCompanyID, ChildEmail, ChildLastName, ChildFirstName, ChildMemberType, ChildOptOutTNB) AS (
		SELECT C.ID, C.CompanyID, C.Email, C.LastName, C.FirstName, C.MemberType, O.New_Brewer_Opt_Out 
		FROM vBoCsContact C
			LEFT JOIN vBoCsBA_Opt O ON C.ID = O.ID 
		WHERE [Status] = 'A'
	)
	SELECT DISTINCT vBoInstitute.ContactKey AS key_UniformKey, 
		vBoCsContact.Email, vBoCsContact.ID AS IMIS_ID, 
		vBoCsContact.CompanyId AS CompanyID, 
		vBoCsContact.MemberType AS ParentMemberType, 
		vBoCsContact.IsCompany, 
		vBoCsContact.LastName AS ParentLastName, 
		vBoCsContact.FirstName AS ParentFirstName, 
		vBoCsContact.Company, 
		--vBoCsBA_Opt.New_Brewer_Opt_Out AS ParentOptOutTNB,
		CASE WHEN vBoCsBA_Opt.New_Brewer_Opt_Out IS NULL THEN @False ELSE vBoCsBA_Opt.New_Brewer_Opt_Out END AS ParentOptOutTNB, 
		ChildContacts.* 
	FROM  vBoInstitute 
		CROSS JOIN vBoContactTypeRef 
		INNER JOIN vBoCsContact ON vBoInstitute.ID = vBoCsContact.CompanyId 
		LEFT JOIN ChildContacts ON vBoCsContact.ID = ChildContacts.ChildCompanyID 
		LEFT JOIN vBoCsBA_Opt ON vBoCsContact.ID = vBoCsBA_Opt.ID 
	WHERE ((vBoInstitute.AccessKey IS NULL OR EXISTS 
		(SELECT 1 FROM AccessItem zai INNER JOIN UserToken zut ON zai.Grantee = zut.Grantee 
			WHERE zai.AccessKey = vBoInstitute.AccessKey AND zut.UserKey = 'e982d078-994a-4bf9-b424-1010e64097d4' 
				AND (zai.Permission&3)>0))) AND ((vBoInstitute.ContactStatusCode = '1' AND vBoCsContact.Status = 'A'))     
		AND vBoCsContact.CompanyId = @IMIS_ID
		--BEW For DEV, ignore emails with value 'delete' since this is the value I used to indicate future deletion which I assume Shane will handle
		AND ISNULL(vBoCsContact.Email, '') <> 'delete' AND ISNULL(ChildContacts.ChildEmail, '') <> 'delete'
	ORDER BY vBoCsContact.LastName , vBoCsContact.FirstName , ChildContacts.ChildLastName , ChildContacts.ChildFirstName
END  

GRANT EXEC ON [spba_GetCompanyRoster] TO iMIS_Prod_RO

