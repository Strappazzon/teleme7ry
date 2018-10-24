# TELEME7RY
#### An automated batch script to disable telemetry in Windows 7

Teleme7ry aims to remove any telemetry service, schedule and update in Windows 7.

![](https://puu.sh/BPXHI.png)

Credits:
- https://superuser.com/a/972506
- https://www.getblackbird.net/blacklist/updates/
- https://www.ghacks.net/2017/02/11/blocking-telemetry-in-windows-7-and-8-1/
- https://deskroll.com/blog/article.php?id=Privacy_In_Windows_7_%E2%80%93_How_To_Disable_Telemetry_Data_Collection

## Removing any leftovers
Follow the steps below **after** running the script to make sure the script ran correctly.

### Check Task Scheduler
Press **Win + R**, type in `taskschd.msc` and hit enter. The Task Scheduler Library will show up.
Expand **Task Scheduler Library > Microsoft > Windows**. If there are any of the following tasks, *delete* them.

- Everything under "*Application Experience*"
- Everything under "*Autochk*"
- Everything under "*Customer Experience Improvement Program*"
- Under "*Disk Diagnostic*"
	- "*Microsoft-Windows-DiskDiagnosticDataCollector*"
- Under "*Maintenance*"
	- "*WinSAT*"
- Under "*CloudExperienceHost*"
	- "*CreateObjectTask*"
- Under "*NetTrace*"
	- "*GatherNetworkInfo*"
- Under "*Shell*"
	- "*FamilySafetyMonitor*"
	- "*FamilySafetyRefresh*"
- Under "*IME*"
	- "*SQM data sender*"

### Hide the uninstalled Updates
Press **Win + R**, type in `control` and hit enter. The Control Panel will show up.
Navigate to **System and Security** > **Windows Update** and hide the following updates under **Important** and **Optional**:

- [KB971033](https://support.microsoft.com/en-us/kb/971033) Windows Activation / Genuine Advantage (WGA)
- [KB2902907](https://support.microsoft.com/en-us/kb/2902907) No official description available, a spyware patch posing as a MSSE/Defender update
- [KB2922324](https://support.microsoft.com/en-us/kb/2922324) No official description available, a pulled update having to do with Windows 10 Upgrade
- [KB2952664](https://support.microsoft.com/en-us/kb/2952664) Compatibility update for upgrading Windows 7 to Windows 10
- [KB2976978](https://support.microsoft.com/en-us/kb/2976978) Compatibility update for upgrading Windows 8/8.1 to Windows 10
- [KB2976987](https://support.microsoft.com/en-us/kb/2976987) Telemetry update for Windows 7
- [KB2977759](https://support.microsoft.com/en-us/kb/2977759) Compatibility update for upgrading Windows 7 RTM to Windows 10
- [KB2990214](https://support.microsoft.com/en-us/kb/2990214) Enables upgrading Windows 7 to later Windows versions
- [KB3012973](https://support.microsoft.com/en-us/kb/3012973) No official description available, a pulled update having to do with Windows 10 Upgrade
- [KB3014460](https://support.microsoft.com/en-us/kb/3014460) No official description available, another pulled Windows 10 Upgrade KB
- [KB3015249](https://support.microsoft.com/en-us/kb/3015249) No official description available, another pulled Windows 10 Upgrade KB
- [KB3021917](https://support.microsoft.com/en-us/kb/3021917) Diagnostic/Telemetry update for Windows 7, another Windows 10 Upgrade KB
- [KB3022345](https://support.microsoft.com/en-us/kb/3022345) CEIP/Telemetry update for Windows 7 and 8/8.1, another Windows 10 Upgrade KB
- [KB3035583](https://support.microsoft.com/en-us/kb/3035583) The Dreaded GWX itself. Windows 7 and 8.1
- [KB3044374](https://support.microsoft.com/en-us/kb/3044374) Enables upgrading Windows 8.1 to Windows 10
- [KB3046480](https://support.microsoft.com/en-us/kb/3046480) Checks if .NET Framework 1.1 needs to be migrated when upgrading Windows 7 or 8.1
- [KB3050265](https://support.microsoft.com/en-us/kb/3050265) Windows Update Client for Windows 7/Server 2008 (June 2015)
- [KB3050267](https://support.microsoft.com/en-us/kb/3050267) Windows Update Client for Windows 8.1/Server 2012 (June 2015)
- [KB3064683](https://support.microsoft.com/en-us/kb/3064683) Windows 8.1 OOBE modifications to reserve Windows 10
- [KB3065987](https://support.microsoft.com/en-us/kb/3065987) Windows Update Client for Windows 7/Server 2008 (July 2015)
- [KB3065988](https://support.microsoft.com/en-us/kb/3065988) Windows Update Client for Windows 8.1/Server 2012 (July 2015)
- [KB3068707 / KB3068708](https://support.microsoft.com/en-us/kb/3068708) CEIP/Telemetry update for Windows 7 and 8.1
- [KB3072318](https://support.microsoft.com/en-us/kb/3072318) Update for Windows 8.1 OOBE to upgrade to Windows 10
- [KB3075249](https://support.microsoft.com/en-us/kb/3075249) Telemetry update for Windows 7 and 8.1
- [KB3075851](https://support.microsoft.com/en-us/kb/3075851) Windows Update Client for Windows 7/Server 2008 (August 2015)
- [KB3075853](https://support.microsoft.com/en-us/kb/3075853) Windows Update Client for Windows 8/Server 2012 (August 2015)
- [KB3080149](https://support.microsoft.com/en-us/kb/3080149) CEIP/Telemetry update for Windows 7 and 8.1
- [KB3080351](https://support.microsoft.com/en-us/kb/3080351) Windows 10 notification and upgrade options management
- [KB3081427 / KB3081437](https://support.microsoft.com/en-us/kb/3081437) Compatibility update for upgrading to Windows 10 (August 2015)
- [KB3081451 / KB3081454](https://support.microsoft.com/en-us/kb/3081454) Compatibility update for upgrading to Windows 10 (September 2015)
- [KB3083324](https://support.microsoft.com/en-us/kb/3083324) Windows Update Client for Windows 7/Server 2008 (September 2015)
- [KB3083325](https://support.microsoft.com/en-us/kb/3083325) Windows Update Client for Windows 8.1/Server 2012 (September 2015)
- [KB3083710](https://support.microsoft.com/en-us/kb/3083710) Windows Update Client for Windows 7/Server 2008 (October 2015)
- [KB3083711](https://support.microsoft.com/en-us/kb/3083711) Windows Update Client for Windows 8.1/Server 2012 (October 2015)
- [KB3090045](https://support.microsoft.com/en-us/kb/3090045) Windows Update for reserved devices in Windows 8.1 or Windows 7 SP1
- [KB3095675](https://support.microsoft.com/en-us/kb/3095675) Windows 10 Upgrade Scheduling
- [KB3112336](https://support.microsoft.com/en-us/kb/3112336) Windows Update Client for Windows 8.1/Server 2012 (December 2015)
- [KB3112343](https://support.microsoft.com/en-us/kb/3112343) Windows Update Client for Windows 7/Server 2008 (December 2015)
- [KB3123862](https://support.microsoft.com/en-us/kb/3123862) Quote: "Updated capabilities to upgrade Windows 8.1 and 7"
- [KB3124275](https://support.microsoft.com/en-us/kb/3124275) Windows 10 nagware posing as a "Cumulative Security Update for Internet Explorer on Windows 7 x64-based Systems"
- [KB3134814](https://support.microsoft.com/en-us/kb/3134814) Windows 10 nagware posing as a "Cumulative Security Update for Internet Explorer on Windows 7 x64-based Systems"
- [KB3135445](https://support.microsoft.com/en-us/kb/3135445) Windows Update Client for Windows 7/Server 2008 (February 2016)
- [KB3138612](https://support.microsoft.com/en-us/kb/3138612) Windows Update Client for Windows 7/Server 2008 (March 2016)
- [KB3138615](https://support.microsoft.com/en-us/kb/3138615) Windows Update Client for Windows 8.1/Server 2012 (March 2016)
- [KB3139929](https://support.microsoft.com/en-us/kb/3139929) Another "security update for Internet Explorer". In reality it's Windows 10 nagware for your browser
- [KB3140166](https://support.microsoft.com/en-us/kb/3140166) Windows 10 Upgrade Scheduling
- [KB3140185](https://support.microsoft.com/en-us/kb/3140185) Windows Anytime Upgrade (WAU) update for Windows 8.1 (March 2016)
- [KB3146449](https://support.microsoft.com/en-us/kb/3146449) "Updated Internet Explorer 11 capabilities to upgrade Windows 8.1 and Windows 7"
- [KB3150513](https://support.microsoft.com/en-us/kb/3150513) May 2016 Compatibility Update for Windows 7, 8, 8.1,another Windows 10 Upgrade KB
- [KB3173040](https://support.microsoft.com/en-us/kb/3173040) Fullscreen Windows 10 nagware experience

![Hide Updates](https://puu.sh/Bn6ke.png)