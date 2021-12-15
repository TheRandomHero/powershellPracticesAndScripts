$modulePath = 'C:\Users\molnara\PowerShell\PowerShell_practice\'
$moduleName = 'first_manifest'

$module = "$($modulePath)$($moduleName).psd1"

Import-Module -Force $module
