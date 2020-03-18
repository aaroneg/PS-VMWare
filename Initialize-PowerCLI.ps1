if (!(Get-installedmodule vmware* -ErrorAction SilentlyContinue)){ 
    Install-Module –Name VMware.PowerCLI -AllowClobber -Scope CurrentUser
}

if (Get-module *vmware*) { write-verbose "VM Modules already loaded"}
else { 
    Import-Module Vmware.PowerCLI
}
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Scope Session -Confirm:$false |out-null

$VCSA=Read-Host -Prompt 'FQDN of vcenter host'

try {Get-ViRole -ErrorAction SilentlyContinue |Out-Null }
catch {
    Write-Host "** Connecting to $VCSA " -ForegroundColor Yellow
    Connect-VIServer -server $VCSA -Protocol https -InformationAction SilentlyContinue |out-null
    Write-Host '** Complete' -ForegroundColor Cyan
    }