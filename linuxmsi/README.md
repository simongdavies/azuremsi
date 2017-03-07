# Deploy A Linux VM with MSI

This template creates a new Linux VM with a MSI and deploys the MSI extension to the VM

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsimongdavies%2Fazuremsi%2Fmaster%2Flinuxmsi%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

ssh to the VM and execute the following commands to get an AccessToken for the MSI for this VM:

```shell
# Set the $tenantId to the value of your AAD tenant Id
tenantId={Your Azure Active Directory Tenant Id}

# Set the resource 

# Get a token for Key Vault
#resource="https://vault.azure.net"

# Get a token for ARM

resource="https://management.azure.com/"

curl --data "authority=https://login.microsoftonline.com/$tenantId&resource=$resource" http://localhost:50342/oauth2/token

```