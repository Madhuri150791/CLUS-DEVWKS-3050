# CLUS-DEVWKS-3050
# Cisco Firepower Threat Defense Deployment in Azure to secure transaction between VNs
Terraform module to deploy a single instance  of Cisco Secure Firewall appliances in Azure.


<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Author](#author)
* [Disclaimer](#disclaimer)
* [Pre-Requisite](#pre-requisite)
* [Usage](#usage)
* [HowTo](#how-tos)
* [RequiredChanges](#changes-to-be-made-in-the-template-for-consuming)
* [Assumption](#assumption)


# Pre-Requisite
Make sure the client from where the template is being executed has terraform installed.

To check if the terraform is installed or not use following command in your CLI:
```commandline
terraform --version
```


# How-Tos
1. Identify the VM SourceImage from MarketPlace.
   To identify the VM Source Image we will be using azure cli
   Run following command, to be able to authenticate to install azure-cli
   - For installing in Windows use following [link](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli) 
   - For installing in Ubuntu use following [link](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
```commandline
#For MacOS
brew install azure-cli 
```
Other authentication methods are defined [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference)
2. Execute following command to get the disk name.
```commandline
az login
```
This will help you to authenticate to azure.

3. Execute following command to fetch the sourceImage Link
```commandline
az vm image list --publisher cisco --all --offer fmcv  --location eastus --output table

az vm image list --publisher cisco --all --offer ftdv  --location eastus --output table

```
The output would be listed as below:

````commandline
MADEWANG-M-WBBL:~ madewang$ az vm image list --publisher cisco --all --offer fmcv  --location eastus --output table
Offer       Publisher    Sku              Urn                                          Version
----------  -----------  ---------------  -------------------------------------------  ----------
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:640113.0.0  640113.0.0
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:66581.0.0   66581.0.0
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:67065.0.0   67065.0.0
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:70184.0.0   70184.0.0
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:70288.0.0   70288.0.0
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:71090.0.0   71090.0.0
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:720.18.0    720.18.0
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:720.36.0    720.36.0
cisco-fmcv  cisco        fmcv-azure-byol  cisco:cisco-fmcv:fmcv-azure-byol:720.64.0    720.64.0

MADEWANG-M-WBBL:~ madewang$ az vm image list --publisher cisco --all --offer ftdv  --location eastus --output table
Offer       Publisher    Sku              Urn                                          Version
----------  -----------  ---------------  -------------------------------------------  ----------
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:640110.0.0  640110.0.0
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:66581.0.0   66581.0.0
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:67065.0.0   67065.0.0
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:70184.0.0   70184.0.0
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:70288.0.0   70288.0.0
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:71092.0.0   71092.0.0
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:720.18.0    720.18.0
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:720.36.0    720.36.0
cisco-ftdv  cisco        ftdv-azure-byol  cisco:cisco-ftdv:ftdv-azure-byol:720.64.0    720.64.0
cisco-ftdv  cisco        ftdv-azure-payg  cisco:cisco-ftdv:ftdv-azure-payg:66581.0.0   66581.0.0
cisco-ftdv  cisco        ftdv-azure-payg  cisco:cisco-ftdv:ftdv-azure-payg:67065.0.0   67065.0.0
cisco-ftdv  cisco        ftdv-azure-payg  cisco:cisco-ftdv:ftdv-azure-payg:70184.0.0   70184.0.0
cisco-ftdv  cisco        ftdv-azure-payg  cisco:cisco-ftdv:ftdv-azure-payg:70288.0.0   70288.0.0
cisco-ftdv  cisco        ftdv-azure-payg  cisco:cisco-ftdv:ftdv-azure-payg:71092.0.0   71092.0.0
cisco-ftdv  cisco        ftdv-azure-payg  cisco:cisco-ftdv:ftdv-azure-payg:720.18.0    720.18.0
cisco-ftdv  cisco        ftdv-azure-payg  cisco:cisco-ftdv:ftdv-azure-payg:720.36.0    720.36.0
cisco-ftdv  cisco        ftdv-azure-payg  cisco:cisco-ftdv:ftdv-azure-payg:720.64.0    720.64.0

````

Select the URN 

For FTDv
cisco:cisco-ftdv:ftdv-azure-payg:71092.0.0

For FMCv
cisco:cisco-fmcv:fmcv-azure-byol:71090.0.0

```html
Aove URNs are already selected in terraform.tfvars file. Do not make changes for this workshop.
```

Before running the orchestration part make sure you have executed
```
az vm image terms accept --urn publisher:offer:sku:version

az vm image terms accept --urn  cisco:cisco-fmcv:fmcv-azure-byol:71090.0.0
az vm image terms accept --urn  cisco:cisco-ftdv:ftdv-azure-payg:71092.0.0
```




# Changes to be made in the Template for consuming
1. Change the contents in variable.tf and terraform.tfvars
2. Follow through main.tf . All the changes required and necessary has been explained there.

# Assumption
- This template is developed keeping in mind that CLoud Team will be using this template for the fresh deployement in GCP, where none of the Networking resources are already built.
- User will have to modify the naming convention of the resources as per the Policy.
- User of this template will be having the access key and secret key for the service account with required permission to build the instances in GCP.


# Details of the Code

This code is categorized to perform the Orchestration and Config Management for Cisco Secure Firewall.

This terraform code makes it easy to set up a new Virtual Network by defining your network and subnet ranges in a concise syntax and aides to build the Single Instance of Cisco Secure Firewall.

It supports creating:

- Virtual Networks
- Subnets within Virtual Network
- Azure Network Security Group
- Route Tables
- Single Instance of Cisco Secure Firewall
- Single Instance of Firepower Management Center

The Ansible code will help to perform:
- Register newly created device to FMC
- Create Access Policy
- Configure the Device (Interface Details- IP, Security Zone and Enabling the interface)
- Add Routes to the devices
- Deploy all the changes made to the devices


## Compatibility

This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+.
If you find incompatibilities using Terraform `>=0.13`, please open an issue.

If you haven't [upgraded][terraform-0.13-upgrade] and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [2.6.0].

## Usage
You need to modify terraform.tfvars files as per your needs. This code will build the Cisco Secure Firewall as shown below
![Single Instance](images/SingleInstance.png?raw=true "Single Instance")

Then perform the following commands on the root folder:

```
cd Orchestration
```

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

Wait for 15-20 mins for FMC and FTD to come up.

Once you are able to get the response from FMC run the ansible commands.

Make sure the FMC IP defined in hosts file is correct and FTD IP defined in vars.yaml is correct.

```commandline
cd ./Config_Management
./commands.sh
ansible-playbook -i hosts main.yaml
ansible-playbook -i hosts setup_device.yaml
ansible-playbook -i hosts policy.yaml
ansible-playbook -i hosts route.yaml
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs  Terraform (Default)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created. | `string` | - | yes |
| location | The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. | `string` | n/a | yes |
| address_space| The address space that is used the virtual network. You can supply more than one address space. | `list` | n/a | yes |
| resource_group_name | The name of the resource group in which to create the virtual network.| `string` | - | yes |
| virtual_network_name  | he name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created. | `string` | - | yes |
| address_prefixes| The address prefixes to use for the subnet.| `string` | - | yes|
| address_prefixes| The address prefixes to use for the subnet.| `string` | - | yes|
| allocation_method| Defines the allocation method for this IP address. Possible values are Static or Dynamic.| `string` | - | yes|
| sku| The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic| `string` | - | no|
| subnet_id | The ID of the Subnet where this Network Interface should be located in.| `string` | - | no|
| private_ip_address| The Static IP Address which should be used.| `string` | - | yes|
| private_ip_address_allocation | The allocation method used for the Private IP Address. Possible values are Dynamic and Static.| `string` | - | yes|
| public_ip_address_id | Reference to a Public IP Address to associate with this NIC | `string` | - | no|
| size| The SKU which should be used for this Virtual Machine, such as Standard_F2.| `string` | - | yes|
| admin_username| The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.| `string` | - | yes|
| admin_password| The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created.| `string` | - | no|
| publisher| Specifies the publisher of the image used to create the virtual machines.| `string` | - | yes|
| offer| Specifies the offer of the image used to create the virtual machines.| `string` | - | yes|
| sku| Specifies the SKU of the image used to create the virtual machines.| `string` | - | yes|
| version| Specifies the version of the image used to create the virtual machines.| `string` | - | yes|


## Outputs

| Name | Description |
|------|-------------|
| fmcpublicip | Public IP for FMC|
| jumphostpubip| Public IP of Jumphost from where Ansible to run |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Ansible Inputs

The subnets list contains maps, where each object represents a subnet. Each map has the following inputs (please see examples folder for additional references):

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ansible_host | Private IP address of the FMC | string | - | yes |
| auth_path | URI for getting FMC authorization token | string | - | yes |
| resource_path | command substring for the URI to access various resources in FMC's REST API | string | - | yes |
| fmc_username | FMC username to authenticate the session| string | | yes |
| fmc_password  | FMC password to authenticate the session| string |  | yes |
| ftds  | List of FTD IPs to be restigered to FMC| list |  | yes |
| zones  | Name of zones to be used for attaching to the interfaces| list of strings | | yes |
| gcpinside  | IP address of the inside gateway in the Azure Subnet | string | | yes |
| gcpoutiside  | IP address of the outside gateway in the Azure Subnet| string | | yes |



### Custom Variables

The  list contains maps, where each object represents a Network and associated Cidr for a subnet within the same. Each map has the following inputs (please see examples folder for additional references):

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| resource\_group\_name\_prefix| This variable is used to define the naming convention for the IaC created resource group in Azure Environment | `string` |`rg` | yes |
| prefix | This is set as a common prefix for the resources to be created in given resource group naming convention.  | `string` |  | yes |
| description | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| resource\_group\_location | Name of the location where the resource are to be created | `string` | `eastus` | yes |
| vnet\_address-space | The Address space for the Virtual Network which will be used by the FMC, FTD and servers  | string | - | yes |
| subnet-mgmt | Subnet to be used for Management Interface | string | - | yes |
| subnet-diag | Subnet to be used for Diagonistic Interface of FTDv | string | - | yes |
| subnet-inside | Subnet to be used for Inside Interface which connects to the trusted Network.| string | - | yes |
| subnet-outside | Subnet to be used for Outside Interface which connects to the untrusted Network | string | - | yes |
| fmcmachinetype | Variable to define the machine type for FMCv | string | - | yes |
| ftdmachinetype | Variable to define the machine type for FTDv | string | -| yes |
| vmmachinetype | Variable to define the machine type for serves| string | -| yes |
| publishercisco | Variable to define FTDv and FMCv publisher detail| string | -| yes |
| publishervm | Variable to define server publisher detail| string | -| yes |
| offerfmc | Variable to define offer details for FMCv| string | -| yes |
| offerftd | Variable to define offer details for FMCv| string | -| yes |
| offertestvm | Variable to define offer details for Test Machines| string | -| yes |
| skufmc | Variable to define SKU details for FMCv| string | -| yes |
| skuftd | Variable to define SKU details for FTDv| string | -| yes |
| skutestvm | Variable to define SKU details for Test Machines| string | -| yes |
| versionfmc | Variable to define Spefic Version details for FMC| string | -| yes |
| versionftd | Variable to define Spefic Version details for FTD| string | -| yes |
| versiontestvm | Variable to define Spefic Version details for Test Machine| string | -| yes |




## Requirements
### Installed Software
- [Terraform](https://www.terraform.io/downloads.html)
- [Terraform Provider for Azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Provider for PKI](https://registry.terraform.io/providers/hashicorp/tls/latest/docs)
- [azure-cli](https://docs.microsoft.com/en-us/cli/azure/) 

### Configure a Service Account

# Author
Modules are maintained by Madhuri Dewangan (madewang@cisco.com, madhuri.dewangan.15@gmail.com)

# Disclaimer
This terraform Template is not an officially supported Cisco product. For official Cisco NGFWv documentation visit the [page](https://www.cisco.com/c/en/us/td/docs/security/firepower/quick_start/gcp/ftdv-gcp-gsg/ftdv-gcp-deploy.html).





