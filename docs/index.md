---
layout: default
title: "Teleme7ry"
description: "Automated batch script to disable telemetry in Windows 7."
---

<h1 align="center">
  <br>
  <img src="https://strappazzon.github.io/teleme7ry/static/img/favicon.png" alt="">
  <br>
  Teleme7ry
  <br>
</h1>

<h4 align="center">Automated batch script to disable telemetry in Windows 7.</h4>

<p align="center">
  <a class="img-badge" href="https://github.com/Strappazzon/teleme7ry">
    <img alt="Source Code" src="https://img.shields.io/badge/Source%20Code-%23444444?style=flat&logo=GitHub">
  </a>
  <a class="img-badge" href="https://github.com/Strappazzon/teleme7ry/releases">
    <img alt="GitHub All Releases" src="https://img.shields.io/github/downloads/Strappazzon/teleme7ry/total?color=%23008080&label=Downloads&logo=DocuSign&logoColor=%23ffffff&style=flat-square">
  </a>
  <a class="img-badge" href="https://github.com/Strappazzon/teleme7ry/releases/latest">
    <img alt="Latest Release" src="https://img.shields.io/github/v/release/Strappazzon/teleme7ry?color=%23000080&include_prereleases&label=Latest%20Release&style=flat-square">
  </a>
</p>

<p align="center">
  <a href="#about">About</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#download">Download</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#credits">Credits</a> •
  <a href="#source-code">Source Code</a> •
  <a href="#license">License</a>
</p>

## About

This batch script will remove telemetry and nagware-related Tasks, Services and Updates.

It will also block [telemetry domains and IPs](https://github.com/Strappazzon/teleme7ry/blob/master/rules.txt).

For more details refer to [the Wiki](https://github.com/Strappazzon/teleme7ry/wiki).

## Getting Started

> ### <img src="https://strappazzon.github.io/teleme7ry/static/img/exclamation.png" width="16px" height="16px"> **WARNING**
>
> Before you proceed, please make sure that:
>
> * Windows Update DOES NOT install updates automatically.
> * hosts file is not write protected. Some antivirus products make it read-only.
> * You have read this README.

Run **teleme7ry.bat** with elevated privileges.

Teleme7ry will run some checks and if they are successful you will be presented with this display:

<a href="https://strappazzon.github.io/teleme7ry/static/img/screenshot.png"><img class="img-responsive" src="https://strappazzon.github.io/teleme7ry/static/img/screenshot.png" alt="Teleme7ry Screenshot"></a>

Here's a description of each task:

* 1\. **Create a restore point**
  * A system restore point with the name "**Teleme7ry vX.Y**" will be created.
    * Make sure that System Restore is On otherwise the task will fail.
* 2\. **Stop and delete telemetry services**
  * Telemetry services will be stopped and deleted. You can see the full list [here](https://github.com/Strappazzon/teleme7ry/wiki/Telemetry-Services).
* 3\. **Delete telemetry and nagware tasks**
  * Telemetry and nagware tasks will be deleted. You can see the full list [here](https://github.com/Strappazzon/teleme7ry/wiki/Telemetry-and-nagware-Tasks).
* 4\. **Block telemetry domains and IPs**
  * Teleme7ry rules will be merged with the hosts file. You can see all the rules [here](https://github.com/Strappazzon/teleme7ry/blob/master/rules.txt).
  * Duplicate lines inside the hosts file, if any, will be removed (due to limitations, this includes hosts entries that have nothing to do with telemetry).
* 5\. **Uninstall telemetry and nagware updates**
  * Telemetry and Nagware updates will be uninstalled. You can see the full list [here](https://github.com/Strappazzon/teleme7ry/wiki/Telemetry-and-Nagware-Updates).
  * Your computer will be restarted aftwerwards.
* A *(case insensitive)*. **Automatic mode: Perform all of the above tasks**
  * The script will go through every task above, in order.
* Q *(case insensitive)*. **Quit**
  * The script will quit without making changes to the system.

> ### <img src="https://strappazzon.github.io/teleme7ry/static/img/information.png" width="16px" height="16px"> **ATTENTION**
>
> Remember to hide the updates uninstalled by Teleme7ry.
>
> Open the Control Panel and navigate to **System and Security** > **Windows Update** > **Check for Updates** and hide all the updates listed [here](https://github.com/Strappazzon/teleme7ry/wiki/Telemetry-and-Nagware-Updates), under **Important** and **Optional**.

<a href="https://strappazzon.github.io/teleme7ry/static/img/hide_updates.png"><img class="img-responsive" src="https://strappazzon.github.io/teleme7ry/static/img/hide_updates.png" alt="Hide Updates"></a>

## Download

You can [download](https://github.com/Strappazzon/teleme7ry/releases/latest) the latest version of Teleme7ry from the Releases page.

## Contributing

If you are interested in fixing issues and contributing directly to Teleme7ry, please see:

* [Contribution Guidelines](https://github.com/Strappazzon/teleme7ry/blob/master/.github/CONTRIBUTING.md)
* [Code of Conduct](https://github.com/Strappazzon/teleme7ry/blob/master/.github/CODE_OF_CONDUCT.md)

## Credits

### Updates, Hosts, Services and Tasks

* [How to stop Microsoft from gathering telemetry data from Windows 7, 8, and 8.1 - Super User](https://superuser.com/a/972506)
* [Blocking Telemetry in Windows 7 and 8.1 - ghacks.net](https://www.ghacks.net/2017/02/11/blocking-telemetry-in-windows-7-and-8-1/)
* [Privacy In Windows 7 – How To Disable Telemetry Data Collection - DeskRoll](https://deskroll.com/blog/article.php?id=Privacy_In_Windows_7_%E2%80%93_How_To_Disable_Telemetry_Data_Collection)
* [dwt_util.py - DisableWinTracking](https://github.com/10se1ucgo/DisableWinTracking/blob/master/dwt_util.py#L138)
* [How to Avoid Windows 7’s End-of-Support Nags - How-To Geek](https://www.howtogeek.com/408556/how-to-avoid-windows-7s-end-of-support-nags/)
* [How to disable the "Your Windows 7 PC is out of support" full screen popup - ghacks.net](https://www.ghacks.net/2019/12/12/how-to-disable-the-your-windows-7-pc-is-out-of-support-full-screen-popop/)
* [Updates Blacklist - Blackbird](https://www.getblackbird.net/blacklist/updates/)

### Logo

* [Icons8](https://icons8.com/icons/set/filter)

## Source Code

The complete Teleme7ry source code is available [on GitHub](https://github.com/Strappazzon/teleme7ry).

## License

> ### <img src="https://strappazzon.github.io/teleme7ry/static/img/notepad_file.png" width="16px" height="16px"> LICENSE.txt - Notepad
>
> <p class="notepad-textarea">
        Copyright (c) 2018 - 2019 Alberto Strappazzon
        <br>
        <br>
        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
        <br>
        <br>
        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.
        <br>
        <br>
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
    </p>
>
