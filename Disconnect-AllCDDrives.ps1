. $PSScriptRoot\Initialize-PowerCLI
$AllVMS = Get-VM | Select-Object Name, @{Label = "ISOfile"; Expression = { ($_ | Get-CDDrive).ISOPath } }
$AllVMs | Where-Object { $_.ISOfile }
$AllVMs | Where-Object { $_.ISOfile } | ForEach-Object { Get-vm $_.Name | Get-CDDrive | Set-CDDrive -NoMedia -confirm:$false }