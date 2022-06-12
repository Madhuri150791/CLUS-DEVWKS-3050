# Cisco Firepower Threat Defense Deployment in Azure to secure transaction between VNs
Terraform template to deploy a single instance  of Cisco Secure Firewall appliances in Azure, and demo automation for VNET Peering for FTD FMC communication.


<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Pre-Requisite](#pre-requisite)
* [Assumption](#assumption)
* [HowTo](#how-tos)
* [Usage](#usage)
* [RequiredChanges](#changes-to-be-made-in-the-template-for-consuming)
* [Author](#author)
* [Disclaimer](#disclaimer)


# Pre-Requisite
Make sure the client from where the template is being executed has terraform installed.

Terraform can be installed from :

https://learn.hashicorp.com/tutorials/terraform/install-cli

Select the host OS on which you are installing Terraform 

To check if  terraform is installed or not use following command in your CLI:
```commandline
terraform --version
```

### Installed Software
- [Terraform](https://www.terraform.io/downloads.html)
- [Terraform Provider for Azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Provider for PKI](https://registry.terraform.io/providers/hashicorp/tls/latest/docs)
- [azure-cli](https://docs.microsoft.com/en-us/cli/azure/)

### Azure Account
User must be having their own Azure Account, to test the template described in this Demo.

### Authenticate Terraform using Service Principal

This method of authentication is preferred when users are using 3rd Party server for execution for example CI servers.

Please refer [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) for using the Client Secrets.


### Authenticate Terraform using Azure CLI

This method of authentication is preferred when user is using the template locally.

This demo will be using Azure CLI authentication mechanism for estiblishing the communication between Terraform and Azure Cloud.

Please refer [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli) for details about local authentication.

# Assumption
- User will be having Azure Subscription with them to run the template.
- Template will be used for green field deployment. This template will be creating resources in a separate resource-group.
- User will have to modify the naming convention of the resources as per the Naming Conventions.
- User will be using Azure CLi authentication mechanism.


# How-Tos {For Information Only}

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

Please Note: All the above action have been performed already to ease the process of Automation. Above is for info only.


# Changes to be made in the Template for consuming
1. Change following contents in terraform.tfvars as per your needs ![changes](images/variable.png?raw=true "Required Changes")





# Details of the Code

This code is categorized to perform the Orchestration and Config Management for Cisco Secure Firewall.

This terraform code makes it easy to set up a new Virtual Network by defining your network and subnet ranges in a concise syntax and aides to build the Single Instance of Cisco Secure Firewall.

It supports creating:

- Virtual Networks
- Subnets within Virtual Network
- Azure Network Security Group
- Route Tables
- Single Instance of Cisco Secure Firewall
- VNET Peer to communicate with FMC [present in separate resource group]

The Ansible code will help to perform:
- Register newly created device to FMC
- Create Access Policy
- Configure the Device (Interface Details- IP, Security Zone and Enabling the interface)
- Add Routes to the devices
- Deploy all the changes made to the devices


## Usage
You need to modify terraform.tfvars files as per your needs. This code will build the Cisco Secure Firewall as shown below
![Single Instance](images/topology.png?raw=true "Single Instance")


Then perform the following commands on the root folder:

```
cd Orchestration
```

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply -auto-approve` to apply the infrastructure build

Wait for 10-15 mins for the FTD to comeup.

Meanwhile copy the content of Config_Management to the Jumphost,

```commandline
cd Config_Management
scp *  madewang@20.228.254.141:~
```

Above statement will copy all the ansible code to the Jumphost, from where FTD and FMCs are reachable.

```ignorelang
Ansible is utilizing FMC REST API for automating the Config Management part.

Make sure the details of the IP are mentioned correctly in the hosts file and vars.yaml file
vars.yaml: This file contains the details of modification which might be required for Configuration within FTD.
credentials.yaml: This file contains the details of the FMC and parameters required to successfully access the REST API of FMC
```
To validate, run the following command

```commandline
cat hosts
cat vars.yaml
cat credentials.yaml
```

Validate Ansible is installed in the jumphost

```commandline
ansible --help
```

If Ansible is not installed run

```commandline
./commands.sh
```

Wait for 15-20 mins for FMC and FTD to come up.

Once you are able to get the response from FMC run the ansible commands.

Make sure the FMC IP defined in hosts file is correct and FTD IP defined in vars.yaml is correct.
Since you will be manually running this ansible playbook, hence please wait 5-10 min between each playbook execution so that the tasks can be completed in FMC.

```commandline
cd ./Config_Management
./commands.sh
ansible-playbook -i hosts main.yaml
ansible-playbook -i hosts setup_device.yaml
ansible-playbook -i hosts policy.yaml
ansible-playbook -i hosts route.yaml
```

```commandline
- `terraform destroy -auto-approve` to destroy the built infrastructure
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



## Compatibility

This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+.
If you find incompatibilities using Terraform `>=0.13`, please open an issue.



# Author
Modules are maintained by Madhuri Dewangan (madewang@cisco.com, madhuri.dewangan.15@gmail.com)

# Disclaimer
This terraform Template is not an officially supported Cisco Template. This is built based on Customer Interaction and Requirements. For official Cisco NGFWv documentation visit the [page](https://www.cisco.com/c/en/us/td/docs/security/firepower/quick_start/gcp/ftdv-gcp-gsg/ftdv-gcp-deploy.html).






