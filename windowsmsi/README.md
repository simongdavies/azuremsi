# Deploy A Windows VM with MSI

This template creates a new Windows VM with a MSI and deploys the MSI extension to the VM

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsimongdavies%2Fazuremsi%2Fmaster%2Fwindowsmsi%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

RDP to the VM and execute the following PowerShell commands to get an AccessToken for the MSI for this VM:

```posh
# Set the $tenantId to the value of your AAD tenant Id
$tenantId={Your Azure Active Directory Tenant Id}

# Set the resource 

# Get a token for Key Vault
#$resource="https://vault.azure.net"

# Get a token for ARM

$resource="https://management.azure.com/"

$postBody=@{authority="https://login.microsoftonline.com/$tenantId"; resource="$resource"}
Invoke-WebRequest -Uri http://localhost:50342/oauth2/token -Method POST -Body $postBody

```