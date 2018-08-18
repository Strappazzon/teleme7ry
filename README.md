# TELEME7RY
#### An automated batch script to disable telemetry in Windows 7

This is a guide on how to remove the leftovers, so follow the steps below **after** running the script.

Credits:
- https://superuser.com/a/972506
- https://www.ghacks.net/2017/02/11/blocking-telemetry-in-windows-7-and-8-1/
- https://deskroll.com/blog/article.php?id=Privacy_In_Windows_7_%E2%80%93_How_To_Disable_Telemetry_Data_Collection

## Check Task Scheduler
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

## Hide the uninstalled Updates
Press **Win + R**, type in `control` and hit enter. The Control Panel will show up.
Navigate to **System and Security** > **Windows Update** and hide the following updates under **Important** and **Optional**:

- **KB3083324** Windows Update Client for Windows 7 and Windows Server 2008 R2: September 2015
- **KB3065987** Windows Update Client for Windows 7 and Windows Server 2008 R2: July 2015
- **KB3050265** Windows Update Client for Windows 7: June 2015
- **KB3075851** Windows Update Client for Windows 7 and Windows Server 2008 R2: August 2015
- **KB2902907** MS Security Essentials/Windows Defender related update
- **KB3068708** Update for customer experience and diagnostic telemetry
- **KB3022345** Update for customer experience and diagnostic telemetry
- **KB2952664** Compatibility update for upgrading Windows 7
- **KB2990214** Update that enables you to upgrade from Windows 7 to a later version of Windows
- **KB3035583** Update installs Get Windows 10 app in Windows 8.1 and Windows 7 SP1
- **KB3021917** Update to Windows 7 SP1 for performance improvements
- **KB3046480** Update helps to determine whether to migrate the .NET Framework 1.1 when you upgrade Windows 8.1 or Windows 7
- **KB3075249** Update that adds telemetry points to consent.exe in Windows 8.1 and Windows 7
- **KB3080149** Update for customer experience and diagnostic telemetry
- **KB3083324** Windows Update Client for Windows 7 and Windows Server 2008 R2: September 2015
- **KB3083710** Windows Update Client for Windows 7 and Windows Server 2008 R2: October 2015
- **KB3123862** Updated capabilities to upgrade Windows 8.1 and Windows 7
- **KB971033** Description of the update for Windows Activation Technologies

![Hide Updates](https://linx.li/selif/hideupdates.png)
