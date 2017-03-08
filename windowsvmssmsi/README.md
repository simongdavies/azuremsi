# Deploy A Windows VMSS with MSI

This template creates a new Windows VMSS with a MSI and deploys the MSI extension and a custom script extension to each VM in the VMSS

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsimongdavies%2Fazuremsi%2Fmaster%2Fwindowsvmssmsi%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

The default configuration will deploy a scaleset with 2 DS1_V2 VMs

The MSI assocaited with the VMSS will be given owner permission on a storage account that is created by the template

Each VM in the scaleset will write a blob to a container in the storage account, each blob will contain the date and time that the file was created