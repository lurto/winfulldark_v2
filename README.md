# WinFullDark

![](https://cdn.iconscout.com/icon/free/png-256/microsoft-windows-2-761692.png)

Features
=============

- Changes the windows background to be completely black
- Activates Windows dark mode
- Puts the Windows accent color to the darkest color possible
- Works even if Winodws is **not** activated 
- **Bypasses** local group policy
- **Bypasses** Active Directory GPO
- Adminstrator Rights **not required**

Warning
=============
+ The script will block the system from accessing this registry key
	+ which is used by the GPOs and the local group policy to set the wallpaper
> HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
	
+ The script will bypass administrator rights requirement for changing the registry ACL
	+ use only with consent from the administrator


Instruction
=============
1. Download the ZIP and unzip it
2. Launch winfulldark_v2.exe

	2.1 !!explorer.exe will be closed and a new explorer.exe will be opened on the PWD!!
3. Launch void_cache.exe

Downsides
=============
- If explorer.exe is restarted in the task manager, the changes will be reverted. (only with Active Directory GPO)
- After a restart or a Windows user log out, the changes will be reverted. (only with Active Directory GPO)

