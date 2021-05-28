# WinFullDark

![](https://cdn.iconscout.com/icon/free/png-256/microsoft-windows-2-761692.png)

Features
=============

- Changes the windows background to be completely black
- Activates Windows dark mode
- Puts the Windows accent to the darkest color possible
- Works even if Winodws is **not** activated 
- **Bypasses** local group policy
- **Bypasses** Active Directory GPO
- Adminstrator Rights **not required**

Warning
=============
+ The script will block the system form accessing this registry key
	+ which used by the GPOs and the local group policy for setting the wallpaper
> HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
	
+ The script will bypass administrator rights requirement for chaging the registry ACL
	+ use only with consent from the administrator


Instruction
=============
1. Download the ZIP and unzip it
2. Launch winfulldark_v2.exe

	2.1 !!explorer.exe will be closed and a new explorer.exe ill be opened on the PWD!!
3. Launch void_cache.exe

Downsides
=============
- If explorer.exe is restarted is the task manager, the changes will be reverted. (only with AD GPO)
- After restart or Winodws user logout, changes will be reverted. (only with AD GPO)

