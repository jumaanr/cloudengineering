#!/bin/bash

#Install Visual Studio Code
wget -O https://go.microsoft.com/fwlink/?LinkID=760868
sudo apt install ./<file>.deb

#Install Terraform
# refernce : https://developer.hashicorp.com/terraform/install
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Install Azure Terraform and Terraform extension for vscode

#----- Create main.tf file --------
# refer : main.tf
# for webapp: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app
# for app service plan: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
# for sql server: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
# for sql database : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database

# Create an Authorized connection with Azure

provider "azurerm" {
  subscription_id = "6912d7a0-bc28-459a-9407-33bbba641c07"
  tenant_id = "70c0f6d9-7f3b-4425-a6b6-09b47643ec58"
  client_id = "3feda701-6a3d-4915-8d26-343827060a8e"
  client_secret = "kKH8Q~54-LwKs2lYfNj6ECD_VmAt-cKSllRG4bfE"
  features {    
  }
}
# subscription_id: This is Azure subscription ID
# Generate an App Registration for this : Microsoft Entra ID --> App Registration --> Give the name 'terraform' --> Register
# After performing above you can get following :
tenant_id:
client_i (This is application ID) :
client_secret: 
# To get the client secret : App Registration --> Terraform --> Client Secrets --> New Client Secret --> Give name and period of validity --> Add --> Generated Client Secret
# This would help to generate an Authorized connection with Azure

# How to give terraform app necessary permissions to modify resources in Azure
# Azure Portal --> Subscription --> Access Control (IAM) --> Add Roles Assignment --> Select 'Contributor' role --> Assign Access to User, Group , Service Principal --> Select Members --> [#]
# --> Select 'terraform' --> Select 'Review and Assign'
# Above step would give Terraform necesssary permissiosn to create resources 
# Please note that here the privileges are not assigned fine grained and  in Zero Trust Security Model 


# Lets Deploy Resources

terraform init #This would download modules required (Need more conttext here ChatGPT, on what happenes in the brackground)
terraform plan -out main.tfplan # we are creating terraform plan file here ( Need more conttext here ChatGPT, on what happenes in the brackground) . This would compare existing resources in Azure account and measure whats going to be deployed.
terraform apply "main.tfplan" # (Need more conttext here ChatGPT, on what happenes in the brackground). This would apply the plan accordingly
terraform destroy # this would destroy whatver the resoruces created by terraform

# complete the writing 