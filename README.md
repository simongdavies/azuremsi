# Examples showing how to use Azure Managed Service Idenity from within Virtual Machines to access ARM and Azure Resources

This repo contains a number of samples that demonstrate how to use Azure MSI from within VMs in Azure, each example accesses ARM to get an storage account key and then uses that key to write a blob to Azure Storage:

- [Windows VM](windowsmsi/README.md)
- [Windows VMSS](windowsvmssmsi/README.md)
- [Linux VM](linuxmsi/README.md)
- [Linux VMSS](linuxvmssmsi/README.md)
