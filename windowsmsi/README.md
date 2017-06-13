# Deploy A Windows VM with MSI

This template creates a new Windows VM with a MSI and deploys the MSI extension to the VM,The MSI associated with the VM is given owner permission on the storage account that is created by the template, then a script is run using the customscript extension that installs Azure PowerShell modules, gets an oauth token and logs in using it,. It then retrieves storage keys for the storage account and writes a blob using that key.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsimongdavies%2Fazuremsi%2Fmaster%2Fwindowsmsi%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
