@echo off
:init
set name=Teleme7ry
set scriptver=1.8
title %name%
goto checksystem
:checksystem
cls
echo.
echo Checking operating system...
ping 127.0.0.1 -n 2 > nul
net session >nul 2>&1
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.1" (goto admin) else (goto incompatible)
endlocal
:incompatible
cls
color 4f
echo.
echo ERROR: %name% is not compatible with this operating system.
timeout /t -1
exit
:admin
echo.
echo Checking permissions...
ping 127.0.0.1 -n 2 > nul
net session >nul 2>&1
if %errorLevel% == 0 (goto home) else (goto error)
goto admin
:error
cls
color 4f
echo.
echo ERROR: %name% needs elevated privileges in order to make changes to your system.
timeout /t -1
exit
:home
cls
color 3f
echo %name% [Version: %scriptver%]
echo Copyright (c) 2019 Alberto Strappazzon. MIT License.
echo.
echo Before you proceed:
echo  - Make sure that Windows Update DOES NOT install updates automatically.
echo  - READ the Readme file.
echo.
echo AVAILABLE TASKS:
echo.
echo 1. Create a restore point
echo 2. Stop and delete telemetry services
echo 3. Delete telemetry tasks
echo 4. Block telemetry domains and IPs
echo 5. Uninstall telemetry and nagware updates
echo     - Your computer will be restarted afterwards
echo     - Remember to hide the uninstalled updates
echo A. Automatic mode: Perform all of the above tasks
echo Q. Quit
echo.
set /p userchoice=TYPE AN OPTION (1-5, A, Q): 
if "%userchoice%"=="1" goto restore
if "%userchoice%"=="2" goto services
if "%userchoice%"=="3" goto tasks
if "%userchoice%"=="4" goto hosts
if "%userchoice%"=="5" goto updates
if /I "%userchoice%"=="A" goto restore
if /I "%userchoice%"=="Q" exit
goto home
:restore
cls
color 07
echo.
echo CREATING A SYSTEM RESTORE POINT...
echo ===========================================
echo.
echo Please make sure System Restore is On.
echo System Properties ^> System Protection ^> Configure...
echo.
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Teleme7ry %scriptver%", 100, 7
if /I "%userchoice%" == "A" (
	timeout /t 5
	goto services
) else (
	timeout /t -1
	goto home
)
:services
cls
color 07
echo.
echo STOPPING AND DELETING TELEMETRY SERVICES...
echo ===========================================
sc stop DiagTrack
sc delete DiagTrack
sc stop dmwappushservice
sc delete dmwappushservice
sc stop RemoteRegistry
sc delete RemoteRegistry
takeown /f "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /grant administrators:F
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /inheritance:r /deny SYSTEM:F /grant Administrators:F
echo "" > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl
if /I "%userchoice%" == "A" (
	timeout /t 5
	goto tasks
) else (
	timeout /t -1
	goto home
)
:tasks
cls
color 07
echo.
echo DELETING TELEMETRY TASKS...
echo ===========================================
schtasks /delete /tn "\Microsoft\Windows\Application Experience\AitAgent" /f
schtasks /delete /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /f
schtasks /delete /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /f
schtasks /delete /tn "\Microsoft\Windows\Autochk\Proxy" /f
schtasks /delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /f
schtasks /delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /f
schtasks /delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /f
schtasks /delete /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /f
schtasks /delete /tn "\Microsoft\Windows\Maintenance\WinSAT" /f
schtasks /delete /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /f
schtasks /delete /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /f
schtasks /delete /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /f
schtasks /delete /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /f
schtasks /delete /tn "\Microsoft\Windows\IME\SQM data sender" /f
if /I "%userchoice%" == "A" (
	timeout /t 5
	goto hosts
) else (
	timeout /t -1
	goto home
)
:hosts
cls
color 07
echo APPLYING HOSTS RULES...
echo ===========================================
echo.
echo Merging Teleme7ry rules with system hosts...
if not exist "%~dp0\working\" mkdir %~dp0\working
type %windir%\System32\drivers\etc\hosts %~dp0\rules.txt > %~dp0\working\merged.txt
echo Parsing and evaluating hosts...
echo This could take a while depending on the lenght of your hosts file. Please wait.
setlocal disableDelayedExpansion
set "mergefile=%~dp0\working\merged.txt"
set "dupl=%mergefile%_dupl"
set "cleaned=%mergefile%_cleaned"
set LF=^


>"%cleaned%" (
	for /f usebackq^ eol^=^%LF%%LF%^ delims^= %%A in ("%mergefile%") do (
		set "ln=%%A"
		setlocal enableDelayedExpansion
		>"%dupl%" (echo !ln:\=\\!)
		>nul findstr /ilg:"%dupl%" "%cleaned%" || (echo !ln!)
		endlocal
	)
)
>nul move /y "%cleaned%" "%~dp0\working\hosts_clean.txt"
2>nul del "%dupl%"
echo Replacing system hosts file...
move /y "%~dp0\working\hosts_clean.txt" "%windir%\System32\drivers\etc\hosts"
echo.
echo Cleaning up...
del /s /q %~dp0\working
rmdir /q %~dp0\working
echo.
echo Flushing DNS resolver cache...
ipconfig /flushdns
if /I "%userchoice%" == "A" (
	timeout /t 5
	goto updates
) else (
	timeout /t -1
	goto home
)
:updates
cls
color 07
echo UNINSTALLING UPDATES...
echo This will take a while, please wait.
echo ===========================================
echo.
echo Uninstalling KB2922324: No description available.
wusa /uninstall /kb:2922324 /quiet /norestart
echo Uninstalling KB2976987: Telemetry update for Windows 7.
wusa /uninstall /kb:2976987 /quiet /norestart
echo Uninstalling KB3012973: No description available.
wusa /uninstall /kb:3012973 /quiet /norestart
echo Uninstalling KB3014460: No description available.
wusa /uninstall /kb:3014460 /quiet /norestart
echo Uninstalling KB3015249: No description available.
wusa /uninstall /kb:3015249 /quiet /norestart
echo Uninstalling KB3064683: Windows 8.1 OOBE modifications to reserve Windows 10.
wusa /uninstall /kb:3064683 /quiet /norestart
echo Uninstalling KB3068707: CEIP/Telemetry update for Windows 7.
wusa /uninstall /kb:3068707 /quiet /norestart
echo Uninstalling KB3072318: Update for Windows 8.1 OOBE to upgrade to Windows 10.
wusa /uninstall /kb:3072318 /quiet /norestart
echo Uninstalling KB3080351: Windows 10 notification and upgrade options management.
wusa /uninstall /kb:3080351 /quiet /norestart
echo Uninstalling KB3081427: Compatibility update for upgrading to Windows 10.
wusa /uninstall /kb:3081427 /quiet /norestart
echo Uninstalling KB3081437: Compatibility update for upgrading to Windows 10.
wusa /uninstall /kb:3081437 /quiet /norestart
echo Uninstalling KB3081451: Compatibility update for upgrading to Windows 10.
wusa /uninstall /kb:3081451 /quiet /norestart
echo Uninstalling KB3081454: Compatibility update for upgrading to Windows 10.
wusa /uninstall /kb:3081454 /quiet /norestart
echo Uninstalling KB3090045: Update for reserved devices in Windows 7 SP1.
wusa /uninstall /kb:3090045 /quiet /norestart
echo Uninstalling KB3095675: Windows 10 Upgrade Scheduling.
wusa /uninstall /kb:3095675 /quiet /norestart
echo Uninstalling KB3112343: Windows Update Client for Windows 7/Server 2008.
wusa /uninstall /kb:3112343 /quiet /norestart
echo Uninstalling KB3124275: Windows 10 nagware for Internet Explorer.
wusa /uninstall /kb:3124275 /quiet /norestart
echo Uninstalling KB3134814: Windows 10 nagware for Internet Explorer.
wusa /uninstall /kb:3134814 /quiet /norestart
echo Uninstalling KB3135445: Windows Update Client for Windows 7/Server 2008.
wusa /uninstall /kb:3135445 /quiet /norestart
echo Uninstalling KB3138612: Windows Update Client for Windows 7/Server 2008.
wusa /uninstall /kb:3138612 /quiet /norestart
echo Uninstalling KB3138615: Windows Update Client for Windows 8.1/Server 2012.
wusa /uninstall /kb:3138615 /quiet /norestart
echo Uninstalling KB3139929: Windows 10 nagware for Internet Explorer.
wusa /uninstall /kb:3139929 /quiet /norestart
echo Uninstalling KB3140166: Windows 10 Upgrade Scheduling.
wusa /uninstall /kb:3140166 /quiet /norestart
echo Uninstalling KB3140185: Windows Anytime Upgrade update for Windows 8.1.
wusa /uninstall /kb:3140185 /quiet /norestart
echo Uninstalling KB3146449: Updated Internet Explorer 11 capabilities to upgrade Windows 7.
wusa /uninstall /kb:3146449 /quiet /norestart
echo Uninstalling KB3150513: Compatibility Update for Windows 7, 8, 8.1 (Windows 10 Upgrade KB).
wusa /uninstall /kb:3150513 /quiet /norestart
echo Uninstalling KB3173040: Fullscreen Windows 10 nagware experience.
wusa /uninstall /kb:3173040 /quiet /norestart
echo Uninstalling KB3065988: Windows Update Client for Windows 8.1/Server 2012.
wusa /uninstall /kb:3065988 /quiet /norestart
echo Uninstalling KB3083325: Windows Update Client for Windows 8.1/Server 2012.
wusa /uninstall /kb:3083325 /quiet /norestart
echo Uninstalling KB3083324: Windows Update Client for Windows 7/Server 2008.
wusa /uninstall /kb:3083324 /quiet /norestart
echo Uninstalling KB2976978: Compatibility update for upgrading Windows 8/8.1 to Windows 10.
wusa /uninstall /kb:2976978 /quiet /norestart
echo Uninstalling KB3075853: Windows Update Client for Windows 8/Server 2012.
wusa /uninstall /kb:3075853 /quiet /norestart
echo Uninstalling KB3065987: Windows Update Client for Windows 7/Server 2008.
wusa /uninstall /kb:3065987 /quiet /norestart
echo Uninstalling KB3050265: Windows Update Client for Windows 7/Server 2008.
wusa /uninstall /kb:3050265 /quiet /norestart
echo Uninstalling KB3050267: Windows Update Client for Windows 8.1/Server 2012.
wusa /uninstall /kb:3050267 /quiet /norestart
echo Uninstalling KB3075851: Windows Update Client for Windows 7.
wusa /uninstall /kb:3075851 /quiet /norestart
echo Uninstalling KB2902907: No description available.
wusa /uninstall /kb:2902907 /quiet /norestart
echo Uninstalling KB3068708: CEIP/Telemetry update for Windows 7.
wusa /uninstall /kb:3068708 /quiet /norestart
echo Uninstalling KB3022345: CEIP/Telemetry update for Windows 7 (Windows 10 Upgrade KB).
wusa /uninstall /kb:3022345 /quiet /norestart
echo Uninstalling KB2952664: Compatibility update for upgrading Windows 7 to Windows 10.
wusa /uninstall /kb:2952664 /quiet /norestart
echo Uninstalling KB2990214: Enables upgrading Windows 7 to later Windows versions.
wusa /uninstall /kb:2990214 /quiet /norestart
echo Uninstalling KB3035583: GWX itself.
wusa /uninstall /kb:3035583 /quiet /norestart
echo Uninstalling KB3021917: Diagnostic/Telemetry update for Windows 7 (Windows 10 Upgrade KB).
wusa /uninstall /kb:3021917 /quiet /norestart
echo Uninstalling KB3044374: Enables upgrading Windows 8.1 to Windows 10
wusa /uninstall /kb:3044374 /quiet /norestart
echo Uninstalling KB3046480: Checks if .NET Framework 1.1 needs to be migrated when upgrading Windows 7.
wusa /uninstall /kb:3046480 /quiet /norestart
echo Uninstalling KB3075249: Telemetry update for Windows 7.
wusa /uninstall /kb:3075249 /quiet /norestart
echo Uninstalling KB3080149: CEIP/Telemetry update for Windows 7.
wusa /uninstall /kb:3080149 /quiet /norestart
echo Uninstalling KB2977759: Compatibility update for upgrading Windows 7 RTM to Windows 10.
wusa /uninstall /kb:2977759 /quiet /norestart
echo Uninstalling KB3083710: Windows Update Client for Windows 7/Server 2008.
wusa /uninstall /kb:3083710 /quiet /norestart
echo Uninstalling KB3083711: Windows Update Client for Windows 8.1/Server 2012.
wusa /uninstall /kb:3083711 /quiet /norestart
echo Uninstalling KB3112336: Windows Update Client for Windows 8.1/Server 2012.
wusa /uninstall /kb:3112336 /quiet /norestart
echo Uninstalling KB3123862: Updated capabilities to upgrade Windows 7.
wusa /uninstall /kb:3123862 /quiet /norestart
echo Uninstalling KB971033: Windows Activation / Genuine Advantage (WGA).
wusa /uninstall /kb:971033 /quiet /norestart
echo Uninstalling KB4493132: Windows 7 End of Support nagware.
wusa /uninstall /kb:4493132 /quiet /norestart
if /I "%userchoice%" == "A" (
	timeout /t 5
	goto end
) else (
	timeout /t -1
	goto restart
)
:restart
cls
color 3f
echo.
echo You must restart your computer to apply the changes.
echo Before restarting, save any open files and close all programs.
echo.
echo NOTE: Remember to hide the uninstalled updates.
echo Refer to the README for more info.
echo.
echo When you're ready press any key to restart.
timeout /t -1
shutdown /r
:end
cls
color 3f
echo.
echo %name% has completed all the tasks.
echo.
echo You must restart your computer to apply some changes.
echo Before restarting, save any open files and close all programs.
echo.
echo NOTE: Remember to hide the uninstalled updates.
echo Refer to the README for more info.
echo.
echo When you're ready press any key to restart.
timeout /t -1
shutdown /r
