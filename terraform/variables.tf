variable "filename" {
    default = "/home/cloudadmin/new_pet.txt"
  
}

variable "content" {
    default = "I love my new pet"
  
}
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