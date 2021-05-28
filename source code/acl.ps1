#gets the path to the parent registry for the wallpaper path
#the path is the one used in GPOs
$acl = Get-Acl HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System 

#specifying the access rules
$rule = New-Object System.Security.AccessControl.RegistryAccessRule("NT Authority\System","FullControl","Allow")
$rule2 = New-Object System.Security.AccessControl.RegistryAccessRule("RESTRICTED","ReadKey","Allow")
$rule3 = New-Object System.Security.AccessControl.RegistryAccessRule ("$env:USERNAME","FullControl","Allow")

#remove and set the rules
$acl.RemoveAccessRule($rule)
$acl.RemoveAccessRule($rule2)
$acl.SetAccessRule($rule3)

$acl |Set-Acl -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System