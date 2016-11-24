REM Set WEB_ROOT and PublishService to values appropriate for your environment. 
REM WEB_ROOT = path to your web root folder
REM PublishService = name of the service running publishing executable ****** (Remove this for 20.2) ******

set MY_IPART=%1
set PROJ_DIR=%2
set SOLUTION_DIR=%3
set CONFIG=%4
set IMIS_VERSION=%5

IF %CONFIG%=="Debug" (
	set HOST=\\MASHED
	set SCHEDULER_BIN=\\MASHED\AsiPlatform\Asi.Scheduler_IMIS20\bin
)
IF %CONFIG%=="Release" (
	set HOST=\\MASHTUN
	set SCHEDULER_BIN=\\MASHTUN\AsiPlatform\Asi.Scheduler_IMIS20\bin
)
IF %CONFIG%=="Local" (
	REM BEW I needed the following HOST lines for LOCALHOST (because I had to share my IMIS folder on the network to get the publish to work??? 
	set HOST=\\ITSTAFF-2015\iMIS
	set SCHEDULER_BIN=C:\AsiPlatform\Asi.Scheduler_IMIS20\bin
)

REM If deploying from VPN in Release mode, override path to MASHED and then manually copy files to MASHTUN.
REM set HOST=\\MASHED
REM set SCHEDULER_BIN=\\MASHED\AsiPlatform\Asi.Scheduler_IMIS20\bin

set WEB_ROOT=%HOST%\Net
set ASI_COMMON=%WEB_ROOT%\AsiCommon
set APP_THEME=%WEB_ROOT%\App_Themes\AspenBA
set DEPLOY_PATH=%WEB_ROOT%\iParts\BACustom\%MY_IPART%
set WEB_BIN=%WEB_ROOT%\bin

REM Publishing only applies to IMIS 20.1
IF %IMIS_VERSION% == "20.1" (
	SET PublishService=AsiPublishing20
	SET PUBLISHRUNNING=0
	sc query %PublishService% >nul 2>&1
	IF NOT ERRORLEVEL 1 (
		SC query %PublishService% | FIND "STATE" | FIND "RUNNING" > nul
		IF NOT ERRORLEVEL 1  (
			SET PUBLISHRUNNING=1
			@ECHO ASI Publish Service is Running... stopping service
			SC stop %PublishService% > nul
			ECHO Stopped.
			ECHO.
		)
	)
)

rem Copy common themes\css 
cd %SOLUTION_DIR%..\..\..\BA.IMIS.Common\App_Themes\AspenBA
copy /y /d *.* %WEB_ROOT%\App_Themes\AspenBA

cd %PROJ_DIR%

REM Create iPart directory if it does not exist
IF NOT EXIST %DEPLOY_PATH% (MD %DEPLOY_PATH%)

copy /y /d iPart%MY_IPART%Display.ascx %DEPLOY_PATH%\iPart%MY_IPART%Display.ascx
copy /y /d iPart%MY_IPART%ConfigEdit.ascx %DEPLOY_PATH%\iPart%MY_IPART%ConfigEdit.ascx
copy /y /d iPart%MY_IPART%Help.htm %DEPLOY_PATH%\iPart%MY_IPART%Help.htm
copy /y /d bin\BA.IMIS.Common.dll %WEB_BIN%\BA.IMIS.Common.dll
copy /y /d bin\BA.iParts.%MY_IPART%.dll %WEB_BIN%\BA.iParts.%MY_IPART%.dll
copy /y /d ws%MY_IPART%.asmx %DEPLOY_PATH%\ws%MY_IPART%.asmx

REM IMIS 20.2 - Copy the dll to the Scheduler folder
IF %IMIS_VERSION% == "20.2" (
	copy /y /d bin\BA.IMIS.Common.dll "%SCHEDULER_BIN%\BA.IMIS.Common.dll"
	copy /y /d bin\BA.iParts.%MY_IPART%.dll "%SCHEDULER_BIN%\BA.iParts.%MY_IPART%.dll"
	REM copy /y /d bin\BA.iParts.%MY_IPART%.pdb "%WEB_BIN%\BA.iParts.%MY_IPART%.pdb" ***** BEW This should not be necessary but was included in the original from ASI *****
)

REM Copy JS from TestHarness
cd %SOLUTION_DIR%BA.iParts.TestHarness
copy /y /d Scripts\bootstrap.min.js "%ASI_COMMON%\Scripts\"

IF %IMIS_VERSION% == "20.1" (
	IF "%PUBLISHRUNNING%"=="1" (
		@ECHO Re-starting ASI Publish service...
		SC start %PublishService% > nul
		ECHO Started.
	)
)

pause
