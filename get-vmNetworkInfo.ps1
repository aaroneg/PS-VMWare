. $PSScriptRoot\Initialize-PowerCLI.ps1
$AllVMs = Get-VM
$VMNetInfo = @()
Foreach ($VM in $AllVMs) {
    [array]$AllAdapters = $VM | Get-NetworkAdapter
    foreach ($adapter in $AllAdapters) {
        $entry = [PSCustomObject]@{
            Name    = $VM.Name
            OS      = $VM.ExtensionData.Guest.GuestFullName
            Adapter = $adapter.Name
            Network = $adapter.NetworkName
            Type    = $adapter.Type
            MAC     = $adapter.MacAddress
            IPv4     = (($VM.ExtensionData.Guest.Net | Where-Object {$_.MacAddress -eq $adapter.MacAddress}).IPAddress | Where-Object {$_ -notlike '*:*'}) -join ';'
            IPv6     = (($VM.ExtensionData.Guest.Net | Where-Object {$_.MacAddress -eq $adapter.MacAddress}).IPAddress | Where-Object {$_ -notlike '*.*'}) -join ';'
        }
        $VMNetInfo+= $entry
    }
}
$VMNetInfo | Format-Table -Property *
$VMNetInfo | Export-Csv $PSScriptRoot\vmnetinfo.csv -NoTypeInformation
"$PSScriptRoot\vmnetinfo.csv"
