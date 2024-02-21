# creating resources using local provider

resource "local_file" "pet" {
  filename = "/home/cloudadmin/pets.txt"
  content = "We love pets"
  file_permission = "0700"
}
resource "local_sensitive_file" "games" {
  filename     = "/home/cloudadmin/favorite-games"
  content  = "FIFA 21"
  
}

# rb03: creating resources using multiple providers
resource "random_pet" "my-pet" {
  prefix = "Mrs"
  separator = "."
  length = "2"  
}

# rb04: Using input variables defined in variables.tf file
resource "local_file" "newpet" {

  filename = var.filename
  content = var.content
  
}
# rb05 : using attribute : Making output of one resource to another
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
