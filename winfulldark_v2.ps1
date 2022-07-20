#source :  https://toucharena.com/how-enable-windows-10-dark-theme/#:~:text=Using%20PowerShell%20(Easiest%20Way)&text=Go%20to%20Search%2C%20type%20in%20PowerShell%2C%20and%20open%20it.&text=Now%20go%20to%20Start%20menu,That's%20it!
#disables windows light mode in the registry
function lightmode{
Set-ItemProperty  -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
}

#source :  https://www.powershellgallery.com/packages/Set-DesktopBackGround/1.0.0.0/Content/Set-DesktopBackGround.ps1
function background{
param(
[Parameter(Position=0)]
$R=0,
[Parameter(Position=1)]
$G=0,
[Parameter(Position=2)]
$B=0
)

$code = @'
using System;
using System.Drawing;
using System.Runtime.InteropServices;
using Microsoft.Win32;
 
 
namespace CurrentUser
{
    public class Desktop
    {
        [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        private static extern int SystemParametersInfo(int uAction, int uParm, string lpvParam, int fuWinIni);
        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern int SetSysColors(int cElements, int[] lpaElements, int[] lpRgbValues);
        public const int UpdateIniFile = 0x01;
        public const int SendWinIniChange = 0x02;
        public const int SetDesktopBackground = 0x0014;
        public const int COLOR_DESKTOP = 1;
        public int[] first = {COLOR_DESKTOP};
 
 
        public static void RemoveWallPaper()
        {
            SystemParametersInfo( SetDesktopBackground, 0, "", SendWinIniChange | UpdateIniFile );
            RegistryKey regkey = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
            regkey.SetValue(@"WallPaper", 0);
            regkey.Close();
        }
 
        public static void SetBackground(byte r, byte g, byte b)
        {
            int[] elements = {COLOR_DESKTOP};
 
            RemoveWallPaper();
            System.Drawing.Color color = System.Drawing.Color.FromArgb(r,g,b);
            int[] colors = { System.Drawing.ColorTranslator.ToWin32(color) };
 
            SetSysColors(elements.Length, elements, colors);
            RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Colors", true);
            key.SetValue(@"Background", string.Format("{0} {1} {2}", color.R, color.G, color.B));
            key.Close();
        }
    }
}
 
'@
try
{
    Add-Type -TypeDefinition $code -ReferencedAssemblies System.Drawing.dll 
}catch{
    # An error is thrown if the type [CurrentUser.Desktop] is already created
    # so we ignore it.
}
finally
{
    [CurrentUser.Desktop]::SetBackground($R, $G, $B)
}
}

function image #creates a black PNG and sets it as the background
{
#soucre : #https://stackoverflow.com/questions/2067920/can-i-draw-create-an-image-with-a-given-text-with-powershell
Add-Type -AssemblyName System.Drawing

$filename = "$PWD\bg.png"
$bmp = new-object System.Drawing.Bitmap 450,450 
$brush = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($bmp) 
$graphics.FillRectangle($brush,0,0,$bmp.Width,$bmp.Height) 
$graphics.Dispose() 
$bmp.Save($filename) 

#soucre : #https://c-nergy.be/blog/?p=15291
$code = @' 
using System.Runtime.InteropServices; 
namespace Win32{ 
    
     public class Wallpaper{ 
        [DllImport("user32.dll", CharSet=CharSet.Auto)] 
         static extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ; 
         
         public static void SetWallpaper(string thePath){ 
            SystemParametersInfo(20,0,thePath,3); 
         }
    }
 } 
'@

add-type $code
[Win32.Wallpaper]::SetWallpaper($filename) 
}

#source : https://www.thelazyadministrator.com/2019/08/08/configure-windows-10-accent-color-with-intune-and-powershell/
#changes the windows color accent with registry keys
function coloraccent{

    $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent"
 
 
    #Accent Color Menu Key
    $AccentColorMenuKey = @{
     Key   = 'AccentColorMenu';
     Type  = "DWORD";
     Value = 'ff000000'
    }
 
    If ($Null -eq (Get-ItemProperty -Path $RegPath -Name $AccentColorMenuKey.Key -ErrorAction SilentlyContinue))
    {
     New-ItemProperty -Path $RegPath -Name $AccentColorMenuKey.Key -Value $AccentColorMenuKey.Value -PropertyType $AccentColorMenuKey.Type -Force
    }
    Else
    {
     Set-ItemProperty -Path $RegPath -Name $AccentColorMenuKey.Key -Value $AccentColorMenuKey.Value -Force
    }
 
 
    #Accent Palette Key
    $AccentPaletteKey = @{
     Key   = 'AccentPalette';
     Type  = "BINARY";
     Value = '6b,6b,6b,ff,59,59,59,ff,4c,4c,4c,ff,3f,3f,3f,ff,33,33,33,ff,26,26,26,ff,14,14,14,ff,88,17,98,00'
    }
    $hexified = $AccentPaletteKey.Value.Split(',') | ForEach-Object { "0x$_" }
 
    If ($Null -eq (Get-ItemProperty -Path $RegPath -Name $AccentPaletteKey.Key -ErrorAction SilentlyContinue))
    {
     New-ItemProperty -Path $RegPath -Name $AccentPaletteKey.Key -PropertyType Binary -Value ([byte[]]$hexified)
    }
    Else
    {
     Set-ItemProperty -Path $RegPath -Name $AccentPaletteKey.Key -Value ([byte[]]$hexified) -Force
    }
 
 
    #MotionAccentId_v1.00 Key
    $MotionAccentIdKey = @{
     Key   = 'MotionAccentId_v1.00';
     Type  = "DWORD";
     Value = '0x000000db'
    }
 
    If ($Null -eq (Get-ItemProperty -Path $RegPath -Name $MotionAccentIdKey.Key -ErrorAction SilentlyContinue))
    {
     New-ItemProperty -Path $RegPath -Name $MotionAccentIdKey.Key -Value $MotionAccentIdKey.Value -PropertyType $MotionAccentIdKey.Type -Force
    }
    Else
    {
     Set-ItemProperty -Path $RegPath -Name $MotionAccentIdKey.Key -Value $MotionAccentIdKey.Value -Force
    }
 
    #Start Color Menu Key
    $StartMenuKey = @{
     Key   = 'StartColorMenu';
     Type  = "DWORD";
     Value = 'ff333333'
    }
 
    If ($Null -eq (Get-ItemProperty -Path $RegPath -Name $StartMenuKey.Key -ErrorAction SilentlyContinue))
    {
     New-ItemProperty -Path $RegPath -Name $StartMenuKey.Key -Value $StartMenuKey.Value -PropertyType $StartMenuKey.Type -Force
    }
    Else
    {
     Set-ItemProperty -Path $RegPath -Name $StartMenuKey.Key -Value $StartMenuKey.Value -Force
    }
 
 
    Stop-Process -ProcessName explorer -Force -ErrorAction SilentlyContinue
}

#removes the access of the system on the registry for the wallpaper
function acl {
Invoke-Expression -Command: "start acl.exe"

Set-ItemProperty  -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name Wallpaper -Value "$PWD\bg.png" -force
}


#disables lightmode function
lightmode

#puts a black color as the background even if there is already an image
background
#changes the background image
image

#grey color accent
coloraccent

#disables the access from the system to the registry for the wallpaper
acl

#the explorer will be closed, this command will reopen it - don't forget to manually open void_cache.exe
Invoke-Item -Path $PWD