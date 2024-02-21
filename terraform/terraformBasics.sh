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

# Multiple providers and resources in Terraform - Refer the main.tf rb03

#?------------------------- Using Input Variables ---------------------------------------------------------#

# 1) define a variables.tf file 
# 2) create variables there
# 3) call variables in resource blocks : refer rb04 in main.tf , You do not have to enclose values in double quotes when calling variables

variable "filename" {

    default = "root/pets.txt"
    type = string # can have { string , number :accepts positive or negetive integer, bool = true/false , any  :default value if not specified in variable block } variable types. 
    description = "the path is local file" #description about the variable

}

# Additional variable types
# 1) List #numbered collection of values , each element is indexed, always begins with 0 th index value
# 2) Map # Data represented in the form of key:value pair , default values can have as many values enclosed with curly braces
# 3) Object
# 4) Tuple

# --- List variable ---#
# creating variable in variables.txt
variable "prefix" {

    default = ["Mr", "Mrs", "Sir"]
    type = list
}
# calling variables in main.tf
resource "randome_pet" "my-pet" {

    prefix = var.prefix[0]
}

# ---- Map -----#
# defining a map
variable file-content {

    type = map
    default = {

        "statement1" = "we all love pets"
        "statement2" = "We love animals"
    }
}
# calling a map
resource local_file my-pet {

    filename = "/root/pets.txt"
    content = var.file-content["statement2"]

}

#? ---------------------- List of a Type ----------------#
# We can parse (inject) specific variable type to a list 
#! Default values shoudl always match the type of the list
variable "prefix" {

    default = ["Mr", "Mrs", "Sir"]
    type = list(string) 
}
# List of a numbers
variable "prefix" {

    default = [ 1,2,3 ]
    type = list(number) 
}
#? ---------------------- Map of a Type -------------------#
# Same can be done to map as lists
variable file-content {

    type = map(string)
    default = {

        "statement1" = "we all love pets"
        "statement2" = "We love animals"
    }
}
# Map of a numbers
variable petcount {

    type = map(number)
    default = {

        "dogs" = 1
        "cats" = 3
    }
}

#? --------------------------- Sets --------------------------#
# Sets are similar to lists but shouldnt include duplicate values
variable "fruit" {

    default = ["apple","banana","mango"]
    type = set(string)
}

#? --------------------------- Objects ------------------------#
# Create complex data structure
variable "naruto" {
  
    type = object({
      name = string
      father = string
      mother = string
      age = number
      title = string
      food= list(string)
      favorite_pet = bool
    })

    default = {
      name = "Uzumaki Naruto"
      father = "Minato Namikaze"
      mother = "Kushina Uzumaki"
      age = 33
      title = "Hokage"
      food = [ "Ramen","Onigiri" ]
      favorite_pet = true
    }
}
# calling objects
resource "local_file" "naruto" {

  filename = var.filename
  content = var.naruto.name
  
}
#----- Tuples------#
# Similar to lists , contains of elements. Lists use elements of same variable type. However, tuples uses different variable types.
#! Adding additional variabl types than whats already defined will throw an error. It should follow the correct order
variable kitty {

    type = tuple([string, number, bool])
    default = ["cat",7,true]
}
# valriable calling can be done as same as lists