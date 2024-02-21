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

# creating resources using multiple providers
resource "random_pet" "my-pet" {
  prefix = "Mrs"
  separator = "."
  length = "2"  
}