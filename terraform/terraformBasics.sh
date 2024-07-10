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

#? ----------------------------- Ways of using variables in Terraform -------------------------------#
# There are many ways you can use variables in Terraform
# 1. Using a variable.tf and passing default values
# 2. Passing as commandline flags
        $ terraform apply -var "filename=/root/pets.txt" -var "content=We love pets"
# 3. As Environment variables
        $export TF_VAR_filename="root/pets.txt"
        $export TF_VAR_content="content=We love pets"
        terraform apply
# 4. Variable definition files 
        create a file with extension terraform.tfvars or terraform.tfvars.json , then define variables
        filename="root/pets.txt"
        content="content=We love pets"
        terraform.apply
# 5. Automatically loading variable files
    create file with exntension *.auto.tfvars or *.auto.tfvars.json
    Use the same convention above , this will automatically load the variables to terraform
    terraform.apply
# 6. Any other file names with .tfvars extension should use :
    terraform apply -var-file variables.tfvars

# Variable definition procedence , suppose if a certain variable has been assigned values from different forms above. 
# Terraform will load in following procedance
# 1. Environment Variables
# 2. terraform.tfvars
# 3. *auto.tfvars (alphabatical order)
# 4. -var or -var-file (commandline flags) # this has the highest priority and will override all above values

#? --------------------- Resource Attributes ---------------------------
# Link two resources together using resource attributes
# Consider resource dependancy with each other , we are taking output of one resource and give that input to another resource.
# refer the attribute documentation for outputs : 
# refer rb05 resource in main.tf

resource "local_file" "pet" {
  filename = "/home/cloudadmin/mypets.txt"
  content = "My favourite pet is ${random_pet.my-newpet.id}"
  file_permission = "0700"
}
resource "random_pet" "my-newpet" {
  prefix = "Mrs"
  separator = "."
  length = "2"  
}

# Implicit Dependancy - Terraform knows the dependancy as above example, the resource random_pet , my_newpet will create always befpre local_file
# Explicit Dependancy - Explicitly define that one resource is dependant on other, useful when certain resource depends on another indirectly

resource "local_file" "pet" {
  filename = "/home/cloudadmin/mypets.txt"
  content = "My favourite pet is Mr.Cat"
  file_permission = "0700"

  depends_on = [ random_pet.my-newpet ]

}
resource "random_pet" "my-newpet" {
  prefix = "Mrs"
  separator = "."
  length = "2"  
}

#? ----------------------------- Output variables -------------------------------#
# These variables can be used to store the value of an expression in Terraform
resource "random_pet" "my-newpet" {
  prefix = "Mrs"
  separator = "."
  length = "2"  
}
# save the output of the random pet in a variable called petname
output "pet-name" {

  value = random_pet.my-newpet.id
  description = "Record the value of pet ID generated by the random_pet resource"
  
}
# when we run terraform apply we can see the value of output variable under Outputs:
terraform output # print the value of terraform output variables
terraform output pet-name # to print the value of specific output variable

# Usecase ; To display the provisioned resource in screen  , Or feed other IaC tools or addons such as Ansible Playbooks or Shell Scripts
