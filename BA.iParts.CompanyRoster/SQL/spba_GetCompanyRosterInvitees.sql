ALTER PROC [dbo].[spba_GetCompanyRosterInvitees] (
	@IMIS_ID CHAR(9)
)
AS
BEGIN
	SELECT 	InvitationID, Email,
			SentByLoginID AS [Sent By], Updated AS [Sent Date/Time]
	FROM BA_CompanyRosterInvitations 
	WHERE IMIS_ID = @IMIS_ID 
		AND Received = 0
		AND [Disabled] = 0
END

GRANT EXEC ON [spba_GetCompanyRosterInvitees] TO iMIS_Prod_RO

