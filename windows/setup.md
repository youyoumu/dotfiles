# Disable Win+L

https://superuser.com/questions/1059511/how-to-disable-winl-in-windows-10

1. go to HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System, if there is no System, create one
1. create a 32bit DWORD, name it DisableLockWorkstation
1. set the value of DisableLockWorkstation to 1
1. it will take effect immediately

# Increase keyboard repeat rate

https://superuser.com/questions/1058474/increase-keyboard-repeat-rate-beyond-control-panel-limits-in-windows-10

```
Set-Location "HKCU:\Control Panel\Accessibility\Keyboard Response"

Set-ItemProperty -Path . -Name AutoRepeatDelay       -Value 200
Set-ItemProperty -Path . -Name AutoRepeatRate        -Value 30
Set-ItemProperty -Path . -Name DelayBeforeAcceptance -Value 0
Set-ItemProperty -Path . -Name BounceTime            -Value 0
Set-ItemProperty -Path . -Name Flags                 -Value 47
```

restart computer

# Module

```
Install-Module -Name AudioDeviceCmdlets
Install-Module PSReadLine -Repository PSGallery -Scope CurrentUser -AllowPrerelease -Force
Install-Module -Name PSFzf
```
