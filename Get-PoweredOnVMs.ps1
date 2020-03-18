. $PSScriptRoot\Initialize-PowerCLI
$VMs=Get-vm|Where-Object {$_.PowerState -eq 'PoweredOn'}
$VMs|Select-Object -Property Name,Guest,VMHost,Id|Export-Csv -Path $PSScriptRoot\PoweredOnVMs.csv -NoTypeInformation -Verbose
