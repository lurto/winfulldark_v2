#.bat code for deleting the cache which will clear the wallpaper settings
$code_bat = "del /F /S /Q %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper
del /F /S /Q %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.*"

New-Item -Name void-cache.bat -Value $code_bat
start-process void-cache.bat
Wait-Event -Timeout 1
Remove-Item void-cache.bat 

##########################


#this will make a "windows + D" for refreshing the wallpaper
#source : https://github.com/stefanstranger/PowerShell/blob/master/WinKeys.ps1
 
$source = @"
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Windows.Forms;
namespace KeyboardSend
{
    public class KeyboardSend
    {
        [DllImport("user32.dll")]
        public static extern void keybd_event(byte bVk, byte bScan, int dwFlags, int dwExtraInfo);
        private const int KEYEVENTF_EXTENDEDKEY = 1;
        private const int KEYEVENTF_KEYUP = 2;
        public static void KeyDown(Keys vKey)
        {
            keybd_event((byte)vKey, 0, KEYEVENTF_EXTENDEDKEY, 0);
        }
        public static void KeyUp(Keys vKey)
        {
            keybd_event((byte)vKey, 0, KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP, 0);
        }
    }
}
"@

Add-Type -TypeDefinition $source -ReferencedAssemblies "System.Windows.Forms"

Function Win 
{
    [KeyboardSend.KeyboardSend]::KeyDown("LWin")
    [KeyboardSend.KeyboardSend]::KeyDown("D")
    [KeyboardSend.KeyboardSend]::KeyUp("LWin")

}

#Windows key + D
Win
Wait-Event -Timeout 0.5
Win