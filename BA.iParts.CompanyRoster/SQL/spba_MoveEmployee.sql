ALTER PROCEDURE [dbo].[spba_MoveEmployee]
	@TARGET_ID varchar(10),
	@ID varchar(10)=NULL,
	@LoginID varchar(50)=NULL,
	@MoveRelationships int
AS

IF (dbo.fnba_ValidateMove(@TARGET_ID) = 1 AND @ID IS NOT NULL)
BEGIN
	INSERT INTO Name_Log (DATE_TIME, LOG_TYPE, SUB_TYPE, USER_ID, ID, LOG_TEXT)
	SELECT GETDATE(), 'CO_ADMIN', 'CO_ADMIN', ISNULL(@LoginID, 'MANAGER'), @TARGET_ID, '(Co_Admin) Name.CO_ID: ' + CO_ID + ' -> ' + @ID
	FROM Name
	WHERE ID=@TARGET_ID

	UPDATE Name
	SET CO_ID=@ID
	WHERE ID=@TARGET_ID

	IF @MoveRelationships=1
		exec spba_MoveRelationships @TARGET_ID, @ID, @LoginID
	ELSE
		exec spba_DeleteRelationships @TARGET_ID, @ID, @LoginID

END
ELSE IF ((SELECT CO_ID FROM Name WHERE ID=@TARGET_ID ) = @ID)
	SELECT FULL_NAME + ' is already part of the roster for ' + COMPANY
	FROM Name WHERE ID=@TARGET_ID
ELSE
	SELECT 'Cannot move employee. This employee is listed as the only Company Administrator, Invoice Contact, and/or Owner. You may move this employee once another employee is assigned to each role.'

GRANT EXECUTE ON spba_MoveEmployee TO iMIS_Prod_RO