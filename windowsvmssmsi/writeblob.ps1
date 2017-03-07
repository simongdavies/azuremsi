#Requires -Version 5.0
[CmdletBinding()]   
param(
    [string]
    $SubscriptionId,
    [string]
    $TenantId,
    [string]
    $ResourceGroupName,
    [string]
    $StorageAccountName,
    [string]
    $ContainerName
)

Install-Module AzureRM

$retry=0
$success=$false

# Get a token for ARM

$resource="https://management.azure.com/"
$postBody=@{authority="https://login.microsoftonline.com/$TenantId"; resource="$resource"}

# Retry till we can get a token, this is only needed until we can sequence extensions in VMSS

do
    {
        try
        {
           $reponse=Invoke-WebRequest -Uri http://localhost:50342/oauth2/token -Method POST -Body $postBody
           $result=ConvertFrom-Json -InputObject $reponse.Content
           $success=$true
        }
        catch
        {
            Write-Verbose "Exception $_ trying to login"
            $retry++
            if ($retry -lt 5)
            {
                Write-Verbose 'Sleeeping ...'
                Start-Sleep (Get-Random -Minimum 30 -Maximum 300)
                Write-Verbose "Retrying attempt $retry"
            }
            else
            {
                throw $_
            }
        }
    }
while(!$success)

$retry=0
$success=$false

# Retry till we can the subcription in context , this is needed as the permission is set after the VMSS is created because the identity is not known until the VMSS is created 

do
    {
        try
        {
           # Subscription will be null until permission is granted
           $loginResult=Login-AzureRmAccount -AccessToken $result.access_token -AccountId  $SubscriptionId
           if ($loginResult.Context.Subscription.SubscriptionId -eq $SubscriptionId)
           {
                $success=$true
           }
           else 
           {
                throw "Subscription Id $SubscriptionId not in context"
           }

        }
        catch
        {
            Write-Verbose "Exception $_ trying to login"
            $retry++
            if ($retry -lt 5)
            {
                Write-Verbose 'Sleeeping ...'
                Start-Sleep (Get-Random -Minimum 30 -Maximum 300)
                Write-Verbose "Retrying attempt $retry"
            }
            else
            {
                throw $_
            }
        }
    }
while(!$success)

$ContainerName=$ContainerName.ToLowerInvariant()
$StorageAccountKey=(Get-AzureRmStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName)[0].Value
$StorageContext=New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
if (!(Get-AzureStorageContainer -Context $StorageContext -Name $ContainerName -ErrorAction SilentlyContinue))
{   
    New-AzureStorageContainer -Name $ContainerName -Context $StorageContext -Permission Blob -ErrorAction SilentlyContinue
}

$BlobName=$env:COMPUTERNAME.ToLowerInvariant()
$FileName=[System.IO.Path]::GetTempFileName()
Get-Date|Out-File $FileName  
Set-AzureStorageBlobContent -File $FileName -Container $ContainerName -Blob $BlobName -Context $StorageContext -Force