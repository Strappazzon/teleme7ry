@echo off
:init
set name=Teleme7ry
set namecap=TELEME7RY
set scriptver=1.6
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
echo ERROR: This operating system is not compatible with this tool.
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
echo ERROR: %name% needs elevated privileges in order to make changes.
timeout /t -1
exit
:home
cls
color 3f
echo %name% [Version: %scriptver%]
echo This script will disable telemetry in Windows 7
echo.
echo Please make sure that Windows Update DOES NOT install updates automatically.
echo The following actions will be performed:
echo.
echo - (Optional) A restore point will be created
echo - The services related to telemetry will be stopped and deleted
echo - The tasks related to telemetry will be deleted
echo - The updates related to telemetry will be uninstalled
echo - The domains\IPs used for telemetry will be blocked
echo - (Prompt) Your computer will be restarted
echo.
set /p tel=DO YOU WANT TO PROCEED? (Y/N): 
if /I "%tel%"=="N" exit
if /I "%tel%"=="Y" goto restore
goto home
:restore
cls
color 07
echo.
echo %namecap% V%scriptver% IS RUNNING, PLEASE WAIT...
echo =========================================
ping 127.0.0.1 -n 2 > nul
echo.
set /p res=DO YOU WANT TO MAKE A SYSTEM RESTORE POINT? (Y/N): 
if /I "%res%"=="N" goto start
if /I "%res%"=="Y" wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Teleme7ry", 100, 7
timeout /t -1
goto start
:start
echo.
echo STOPPING AND DELETING THE SERVICES...
echo =========================================
sc stop DiagTrack
sc stop dmwappushservice
sc stop RemoteRegistry
ping 127.0.0.1 -n 1 > nul
sc delete DiagTrack
sc delete dmwappushservice
ping 127.0.0.1 -n 1 > nul
echo "" > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl
echo.
echo.
echo DELETING THE TASKS...
echo =========================================
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
echo.
echo Operation completed.
echo.
echo UNINSTALLING THE UPDATES...
echo This will take a while, please wait.
echo =========================================
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
echo The updates have been uninstalled.
echo.
echo BLOCKING THE DOMAINS AND IPS...
echo =========================================
set hostspath=%windir%\System32\drivers\etc\hosts
echo.>> %hostspath%
echo # ======================================>> %hostspath%
echo # Windows domains\IPs used for telemetry>> %hostspath%
echo # ======================================>> %hostspath%
echo 0.0.0.0 vortex.data.microsoft.com>> %hostspath%
echo 0.0.0.0 vortex-win.data.microsoft.com>> %hostspath%
echo 0.0.0.0 telecommand.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 telecommand.telemetry.microsoft.com.nsatc.net>> %hostspath%
echo 0.0.0.0 oca.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 oca.telemetry.microsoft.com.nsatc.net>> %hostspath%
echo 0.0.0.0 sqm.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 sqm.telemetry.microsoft.com.nsatc.net>> %hostspath%
echo 0.0.0.0 watson.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 watson.telemetry.microsoft.com.nsatc.net>> %hostspath%
echo 0.0.0.0 redir.metaservices.microsoft.com>> %hostspath%
echo 0.0.0.0 choice.microsoft.com>> %hostspath%
echo 0.0.0.0 choice.microsoft.com.nsatc.net>> %hostspath%
echo 0.0.0.0 df.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 reports.wes.df.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 wes.df.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 services.wes.df.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 sqm.df.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 watson.ppe.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 telemetry.appex.bing.net>> %hostspath%
echo 0.0.0.0 telemetry.urs.microsoft.com>> %hostspath%
echo 0.0.0.0 telemetry.appex.bing.net:443>> %hostspath%
echo 0.0.0.0 settings-sandbox.data.microsoft.com>> %hostspath%
echo 0.0.0.0 vortex-sandbox.data.microsoft.com>> %hostspath%
echo 0.0.0.0 survey.watson.microsoft.com>> %hostspath%
echo 0.0.0.0 watson.live.com>> %hostspath%
echo 0.0.0.0 watson.microsoft.com>> %hostspath%
echo 0.0.0.0 statsfe2.ws.microsoft.com>> %hostspath%
echo 0.0.0.0 corpext.msitadfs.glbdns2.microsoft.com>> %hostspath%
echo 0.0.0.0 compatexchange.cloudapp.net>> %hostspath%
echo 0.0.0.0 cs1.wpc.v0cdn.net>> %hostspath%
echo 0.0.0.0 a-0001.a-msedge.net>> %hostspath%
echo 0.0.0.0 statsfe2.update.microsoft.com.akadns.net>> %hostspath%
echo 0.0.0.0 sls.update.microsoft.com.akadns.net>> %hostspath%
echo 0.0.0.0 fe2.update.microsoft.com.akadns.net>> %hostspath%
echo 0.0.0.0 65.55.108.23>> %hostspath%
echo 0.0.0.0 65.39.117.230>> %hostspath%
echo 0.0.0.0 23.218.212.69>> %hostspath%
echo 0.0.0.0 104.41.219.140>> %hostspath%
echo 0.0.0.0 134.170.30.202>> %hostspath%
echo 0.0.0.0 137.116.81.24>> %hostspath%
echo 0.0.0.0 diagnostics.support.microsoft.com>> %hostspath%
echo 0.0.0.0 corp.sts.microsoft.com>> %hostspath%
echo 0.0.0.0 statsfe1.ws.microsoft.com>> %hostspath%
echo 0.0.0.0 pre.footprintpredict.com>> %hostspath%
echo 0.0.0.0 204.79.197.200>> %hostspath%
echo 0.0.0.0 i1.services.social.microsoft.com>> %hostspath%
echo 0.0.0.0 i1.services.social.microsoft.com.nsatc.net>> %hostspath%
echo 0.0.0.0 feedback.windows.com>> %hostspath%
echo 0.0.0.0 feedback.microsoft-hohm.com>> %hostspath%
echo 0.0.0.0 feedback.search.microsoft.com>> %hostspath%
echo 0.0.0.0 s0.2mdn.net>> %hostspath%
echo 0.0.0.0 view.atdmt.com>> %hostspath%
echo 0.0.0.0 2.22.61.43>> %hostspath%
echo 0.0.0.0 2.22.61.66>> %hostspath%
echo 0.0.0.0 157.56.106.189>> %hostspath%
echo 0.0.0.0 65.52.108.33>> %hostspath%
echo 0.0.0.0 64.4.54.254>> %hostspath%
echo 0.0.0.0 onesettings-bn2.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 onesettings-cy2.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 onesettings-db5.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 onesettings-hk2.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 reports.wes.df.telemetry.microsoft.com>> %hostspath%
echo 0.0.0.0 settings.data.glbdns2.microsoft.com>> %hostspath%
echo 0.0.0.0 sqm.telemetry.microsoft.com.nsatc.net>> %hostspath%
echo 0.0.0.0 telecommand.telemetry.microsoft.com.nsat­c.net>> %hostspath%
echo 0.0.0.0 v10.vortex-win.data.microsoft.com>> %hostspath%
echo 0.0.0.0 v10.vortex-win.data.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 vortex.data.glbdns2.microsoft.com>> %hostspath%
echo 0.0.0.0 vortex.data.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 vortex-bn2.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 vortex-cy2.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 vortex-db5.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 vortex-hk2.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 vortex-win.data.metron.live.com.nsatc.net>> %hostspath%
echo 0.0.0.0 a-0001.dc-msedge.net>> %hostspath%
echo 0.0.0.0 a-0002.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0003.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0003.dc-msedge.net>> %hostspath%
echo 0.0.0.0 a-0004.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0005.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0006.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0007.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0008.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0009.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0010.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0011.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-0012.a-msedge.net>> %hostspath%
echo 0.0.0.0 a-msedge.net>> %hostspath%
echo 0.0.0.0 a.ads1.msn.com>> %hostspath%
echo 0.0.0.0 a.ads2.msads.net>> %hostspath%
echo 0.0.0.0 a.ads2.msn.com>> %hostspath%
echo 0.0.0.0 a.rad.msn.com>> %hostspath%
echo 0.0.0.0 ac3.msn.com>> %hostspath%
echo 0.0.0.0 activity.windows.com>> %hostspath%
echo 0.0.0.0 adnexus.net>> %hostspath%
echo 0.0.0.0 adnxs.com>> %hostspath%
echo 0.0.0.0 adl.windows.com>> %hostspath%
echo 0.0.0.0 ads.msn.com>> %hostspath%
echo 0.0.0.0 ads1.msads.net>> %hostspath%
echo 0.0.0.0 ads1.msn.com>> %hostspath%
echo 0.0.0.0 aidps.atdmt.com>> %hostspath%
echo 0.0.0.0 aka-cdn-ns.adtech.de>> %hostspath%
echo 0.0.0.0 array101-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array102-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array103-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array104-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array201-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array202-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array203-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array204-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array401-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array402-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array403-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array404-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array405-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array406-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array407-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 array408-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 b.ads1.msn.com>> %hostspath%
echo 0.0.0.0 b.ads2.msads.net>> %hostspath%
echo 0.0.0.0 b.rad.msn.com>> %hostspath%
echo 0.0.0.0 bingads.microsoft.com>> %hostspath%
echo 0.0.0.0 bl3301-a.1drv.com>> %hostspath%
echo 0.0.0.0 bl3301-c.1drv.com>> %hostspath%
echo 0.0.0.0 bl3301-g.1drv.com>> %hostspath%
echo 0.0.0.0 bn2b-cor001.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 bn2b-cor002.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 bn2b-cor003.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 bn2b-cor004.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 bn2wns1.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3p-cor001.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 bn3sch020010558.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020010560.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020010618.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020010629.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020010631.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020010635.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020010636.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020010650.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020011727.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020012850.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020020322.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020020749.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020022328.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020022335.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn3sch020022361.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101120814.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101120818.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101120911.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101120913.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121019.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121109.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121118.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121223.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121407.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121618.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121704.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121709.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121714.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101121908.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101122117.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101122310.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101122312.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101122421.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101123108.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101123110.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch101123202.wns.windows.com>> %hostspath%
echo 0.0.0.0 bn4sch102110124.wns.windows.com>> %hostspath%
echo 0.0.0.0 bs.serving-sys.com>> %hostspath%
echo 0.0.0.0 by3301-a.1drv.com>> %hostspath%
echo 0.0.0.0 by3301-c.1drv.com>> %hostspath%
echo 0.0.0.0 by3301-e.1drv.com>> %hostspath%
echo 0.0.0.0 c-0001.dc-msedge.net>> %hostspath%
echo 0.0.0.0 c.atdmt.com>> %hostspath%
echo 0.0.0.0 c.msn.com>> %hostspath%
echo 0.0.0.0 cache.datamart.windows.com>> %hostspath%
echo 0.0.0.0 cdn.atdmt.com>> %hostspath%
echo 0.0.0.0 cds10.stn.llnw.net>> %hostspath%
echo 0.0.0.0 cds1203.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1204.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1209.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1219.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1228.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1244.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1257.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1265.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1269.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1273.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1285.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1287.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1289.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1293.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1307.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1310.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1325.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds1327.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds177.dus.llnw.net>> %hostspath%
echo 0.0.0.0 cds20005.stn.llnw.net>> %hostspath%
echo 0.0.0.0 cds20404.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20411.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20415.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20416.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20417.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20424.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20425.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20431.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20435.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20440.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20443.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20445.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20450.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20452.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20457.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20461.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20469.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20475.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20482.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20485.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds20495.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds21205.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21207.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21225.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21229.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21233.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21238.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21244.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21249.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21256.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21257.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21258.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21261.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21267.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21278.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21281.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21293.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21309.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21313.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds21321.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds299.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds308.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds30027.stn.llnw.net>> %hostspath%
echo 0.0.0.0 cds310.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds38.ory.llnw.net>> %hostspath%
echo 0.0.0.0 cds54.ory.llnw.net>> %hostspath%
echo 0.0.0.0 cds405.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds406.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds407.fra.llnw.net>> %hostspath%
echo 0.0.0.0 cds416.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds421.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds422.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds425.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds426.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds447.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds458.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds459.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds461.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds468.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds469.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds471.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds483.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds484.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds489.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds493.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds494.lcy.llnw.net>> %hostspath%
echo 0.0.0.0 cds812.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds815.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds818.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds832.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds836.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds840.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds843.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds857.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds868.lon.llnw.net>> %hostspath%
echo 0.0.0.0 cds869.lon.llnw.net>> %hostspath%
echo 0.0.0.0 ch1-cor001.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 ch1-cor002.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 ch3301-c.1drv.com>> %hostspath%
echo 0.0.0.0 ch3301-e.1drv.com>> %hostspath%
echo 0.0.0.0 ch3301-g.1drv.com>> %hostspath%
echo 0.0.0.0 ch3302-c.1drv.com>> %hostspath%
echo 0.0.0.0 ch3302-e.1drv.com>> %hostspath%
echo 0.0.0.0 compatexchange1.trafficmanager.net>> %hostspath%
echo 0.0.0.0 continuum.dds.microsoft.com>> %hostspath%
echo 0.0.0.0 cy2.settings.data.microsoft.com.akadns.net>> %hostspath%
echo 0.0.0.0 db5.settings.data.microsoft.com.akadns.net>> %hostspath%
echo 0.0.0.0 dev.virtualearth.net>> %hostspath%
echo 0.0.0.0 ec.atdmt.com>> %hostspath%
echo 0.0.0.0 ecn.dev.virtualearth.net>> %hostspath%
echo 0.0.0.0 eu.vortex.data.microsoft.com>> %hostspath%
echo 0.0.0.0 flex.msn.com>> %hostspath%
echo 0.0.0.0 fs.microsoft.com>> %hostspath%
echo 0.0.0.0 g.msn.com>> %hostspath%
echo 0.0.0.0 geo.settings.data.microsoft.com.akadns.net>> %hostspath%
echo 0.0.0.0 geo-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 geover-prod.do.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 h1.msn.com>> %hostspath%
echo 0.0.0.0 h2.msn.com>> %hostspath%
echo 0.0.0.0 hk2.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020721.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020723.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020726.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020729.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020732.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020824.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020843.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020851.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020854.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020855.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020924.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020936.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020940.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020956.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020958.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130020961.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021017.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021029.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021035.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021137.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021142.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021153.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021217.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021246.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021249.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021260.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021264.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021322.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021323.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021329.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021334.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021360.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021432.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021433.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021435.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021437.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021440.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021450.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021518.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021523.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021526.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021527.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021544.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021554.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021618.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021634.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021638.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021646.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021652.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021654.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021657.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021723.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021726.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021727.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021730.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021731.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021754.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021829.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021830.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021833.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021840.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021842.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021851.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021852.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021927.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021928.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021929.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130021958.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130022035.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130022041.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130022049.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2sch130022135.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2wns1.wns.windows.com>> %hostspath%
echo 0.0.0.0 hk2wns1b.wns.windows.com>> %hostspath%
echo 0.0.0.0 i-bl6p-cor001.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 i-bl6p-cor002.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 i-bn3p-cor001.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 i-by3p-cor001.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 i-by3p-cor002.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 i-ch1-cor001.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 i-ch1-cor002.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 i-sn2-cor001.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 i-sn2-cor002.api.p001.1drv.com>> %hostspath%
echo 0.0.0.0 inference.location.live.net>> %hostspath%
echo 0.0.0.0 lb1.www.ms.akadns.net>> %hostspath%
echo 0.0.0.0 live.rads.msn.com>> %hostspath%
echo 0.0.0.0 m.adnxs.com>> %hostspath%
echo 0.0.0.0 mobile.pipe.aria.microsoft.com>> %hostspath%
echo 0.0.0.0 msedge.net>> %hostspath%
echo 0.0.0.0 msntest.serving-sys.com>> %hostspath%
echo 0.0.0.0 nexus.officeapps.live.com>> %hostspath%
echo 0.0.0.0 nexusrules.officeapps.live.com>> %hostspath%
echo 0.0.0.0 preview.msn.com>> %hostspath%
echo 0.0.0.0 rad.live.com>> %hostspath%
echo 0.0.0.0 rad.msn.com>> %hostspath%
echo 0.0.0.0 schemas.microsoft.akadns.net>> %hostspath%
echo 0.0.0.0 secure.adnxs.com>> %hostspath%
echo 0.0.0.0 secure.flashtalking.com>> %hostspath%
echo 0.0.0.0 settings-win-ppe.data.microsoft.com>> %hostspath%
echo 0.0.0.0 settings-win.data.microsoft.com>> %hostspath%
echo 0.0.0.0 settings.data.microsoft.com>> %hostspath%
echo 0.0.0.0 sn3301-c.1drv.com>> %hostspath%
echo 0.0.0.0 sn3301-e.1drv.com>> %hostspath%
echo 0.0.0.0 sn3301-g.1drv.com>> %hostspath%
echo 0.0.0.0 share.microsoft.com>> %hostspath%
echo 0.0.0.0 maps.windows.com>> %hostspath%
echo 0.0.0.0 spynet2.microsoft.com>> %hostspath%
echo 0.0.0.0 spynetalt.microsoft.com>> %hostspath%
echo 0.0.0.0 spyneteurope.microsoft.akadns.net>> %hostspath%
echo 0.0.0.0 ssw.live.com>> %hostspath%
echo 0.0.0.0 storecatalogrevocation.storequality.microsoft.com>> %hostspath%
echo 0.0.0.0 t0.ssl.ak.dynamic.tiles.virtualearth.net>> %hostspath%
echo 0.0.0.0 t0.ssl.ak.tiles.virtualearth.net>> %hostspath%
echo 0.0.0.0 tele.trafficmanager.net>> %hostspath%
echo 0.0.0.0 teredo.ipv6.microsoft.com>> %hostspath%
echo 0.0.0.0 test.activity.windows.com>> %hostspath%
echo 0.0.0.0 tsfe.trafficshaping.dsp.mp.microsoft.com>> %hostspath%
echo 0.0.0.0 version.hybrid.api.here.com>> %hostspath%
echo 0.0.0.0 web.vortex.data.microsoft.com>> %hostspath%
echo 0.0.0.0 win10.ipv6.microsoft.com>> %hostspath%
echo 0.0.0.0 win1710.ipv6.microsoft.com>> %hostspath%
echo 0.0.0.0 win8.ipv6.microsoft.com>> %hostspath%
echo 0.0.0.0 www.msedge.net>> %hostspath%
echo Operation completed.
echo.
echo FLUSHING THE DNS RESOLVER CACHE...
echo =========================================
ipconfig /flushdns
timeout /t -1
:end
cls
color 3f
echo.
echo %namecap% HAS COMPLETED ALL THE TASKS.
echo =========================================
echo To continue choose what you want to do now:
echo.
echo GITHUB: (Recommended) See how to remove the leftovers (if any)
echo RESTART: (Recommended) Restart the computer
echo QUIT: (Not recommended) Quit the script without restarting the computer
echo.
set /p end=TYPE AN OPTION: 
if /I "%end%"=="GITHUB" start https://github.com/Strappazzon/teleme7ry/blob/master/README.md#removing-any-leftovers
if /I "%end%"=="RESTART" goto restart
if /I "%end%"=="QUIT" goto norestart
goto end
:restart
cls
shutdown /r /c "Teleme7ry needs to restart your computer in order to complete the tasks." /t 10
:norestart
exit
