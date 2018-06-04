USE [IMIS20]
GO
/****** Object:  StoredProcedure [dbo].[spba_DeleteFromRoster]    Script Date: 8/11/2017 4:09:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Created by Brent
Modified by Mike on 10/24/2016 - Brent had status changed to Inactive. These records should stay Active but be changed from EMP to NEMP and have their CO_ID removed. I'm also adding a change log entry
Modified by Mike on 11/23/2016 - Now will log the user who made the change instead of mananger
*/
ALTER PROC [dbo].[spba_DeleteFromRoster] (
	@IMIS_ID char(9),
	@SentByLoginID NVARCHAR(255) = NULL
)
AS

INSERT INTO Name_Log (DATE_TIME, LOG_TYPE, SUB_TYPE, USER_ID, ID, LOG_TEXT)
SELECT GETDATE(), 'CO_ADMIN', 'CO_ADMIN', ISNULL(@SentByLoginID, 'MANAGER'), n.ID, '(Co_Admin) Name.MEMBER_TYPE: ' + MEMBER_TYPE + ' -> NEMP'
FROM Name n
WHERE ID = @IMIS_ID

INSERT INTO Name_Log (DATE_TIME, LOG_TYPE, SUB_TYPE, USER_ID, ID, LOG_TEXT)
SELECT GETDATE(), 'CO_ADMIN', 'CO_ADMIN', ISNULL(@SentByLoginID, 'MANAGER'), n.ID, '(Co_Admin) Name.CO_ID: ' + CO_ID + ' -> '
FROM Name n
WHERE ID = @IMIS_ID

INSERT INTO Name_Log (DATE_TIME, LOG_TYPE, SUB_TYPE, USER_ID, ID, LOG_TEXT)
SELECT GETDATE(), 'CO_ADMIN', 'CO_ADMIN', ISNULL(@SentByLoginID, 'MANAGER'), n.ID, '(Co_Admin) Name.COMPANY: ' + COMPANY + ' -> '
FROM Name n
WHERE ID = @IMIS_ID

	UPDATE Name 
	SET MEMBER_TYPE = CASE WHEN MEMBER_TYPE='EMP' OR MEMBER_TYPE='NEMP' THEN 'NEMP' WHEN MEMBER_TYPE='AHAE' OR MEMBER_TYPE='NAHAE' THEN 'NAHAE' ELSE 'NEMP' END, 
		CO_ID='',
		COMPANY='',
		COMPANY_SORT=''
	WHERE ID = @IMIS_ID

DELETE Relationship
WHERE TARGET_ID=@IMIS_ID

GRANT EXEC ON [spba_DeleteFromRoster] TO iMIS_Prod_RO

