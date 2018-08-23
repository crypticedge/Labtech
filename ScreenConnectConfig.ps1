### This script sets the ScreenConnect Client GUID of a client computer
### to a unique value based off a hash of the computer name

## Look at the ScreenConnect service name on computer & stop the service.
$serverid = "CHANGEME"
Stop-Service -displayname "ScreenConnect Client ($serverid)"

## Find current GUID to replace
$rpath = "HKLM:\SYSTEM\CurrentControlSet\Services\ScreenConnect Client ($serverid)"
$ipath = (Get-ItemProperty -path $rpath).ImagePath
$replaceguid = $ipath.Substring(($ipath.IndexOf("&s="))+3,36)

## Generate GUID based off computer name
$someString = $env:COMPUTERNAME
$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = New-Object -TypeName System.Text.UTF8Encoding
$hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($someString)))
[GUID]$guid = $hash.replace("-","")

## Change GUID in ImagePath in registry
Set-ItemProperty -path $rpath -name ImagePath -type String -value $($ipath -replace $("s=" + $replaceguid),$("s="+$guid.ToString()))

##Start ScreenConnect Service
Start-Service -displayname "ScreenConnect Client ($serverid)"