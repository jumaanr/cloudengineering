#!/bin/bash

# Providers and registry : https://registry.terraform.io/
# Terraform documentation : https://developer.hashicorp.com/terraform/docs

#?-------------------------------------Install Terraform--------------------------------------------#

# download terrafrom : https://developer.hashicorp.com/terraform/install?product_intent=terraform

#RHEL
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

#Debian/Ubuntu
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# check terraform installation
terraform version


#? ------------------------ Terraform workflow ----------------------------------------------------------------------#
resource "local_file" # here resource provider is 'local' , the resource type is 'file'

terraform init # initialize: will check the config file and initilizing the working directory containing the .tf file. Will identify the provider and download the plugin.
terraform plan # see the execution plan carried out by terraform, shows the actions that tf will take to create the resource, this step is only to inform the user abotut he execution plan.
terraform apply # to deploy the resource , will promopt of the confirmation
terraform show # see the details of the resources we created . Inspects the state file and display information

# providers documentation : https://registry.terraform.io/providers/hashicorp/local/latest/docs

#?------------------------- Update and Destroy Resources ----------------------------------------------------#

#--Update--#
#1) perform necessary changes in .tf file
terraform plan
terraform apply

#-- Destroy--#
terraform destroy # destroy terraform resources, shows the execution plan as well. 

#?--------------------------- Terraform Providers ---------------------------------------------------------#
# Proper file naming conventions

main.tf # main configuration file containing resource definitions
variables.tf # contains variable declaration
outputs.tf # contains outputs from resources
provider.tf # contains provider definitions

# Multiple providers and resources in Terraform
