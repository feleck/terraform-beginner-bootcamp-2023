variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_access_token" {
  description = "Terratowns Access Token"
  type = string  
}

variable "terratowns_endpoint" {
  description = "Terratowns endpoint"
  type = string  
}

variable "games" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "movies" {
  type = object({
    public_path = string
    content_version = number
  })
}
