#activate numlock at startup using a GPO in powershell
Set-ItemProperty -Path 'Registry::HKU\. DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "2"

#set the default wallpaper for all users using a GPO in powershell
Set-ItemProperty -Path 'Registry::HKU\. DEFAULT\Control Panel\Desktop' -Name "Wallpaper" -Value "H:\wallpaper.jpg"

gpupdate.exe /force