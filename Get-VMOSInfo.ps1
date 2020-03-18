. $PSScriptRoot\Initialize-PowerCLI

$AllVMs=Get-VM
$VMsWithOS=$AllVMs|Select Name,@{Name="OS";Expression={$_.ExtensionData.Guest.GuestFullName}}|Sort -property OS,Name
$VMsWithOS|ft
$VMsWithOS|Export-Csv "$PSScriptRoot\VMsWithOS.csv" -NoTypeInformation
"Output saved to $PSScriptRoot\VMsWithOS.csv"



