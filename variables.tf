variable "teacherseat_user_uuid" {
  type = string
}

# variable "bucket_name" {
#   type = string
# }

# variable "index_html_filepath" {
#   type = string
# }

# variable "error_html_filepath" {
#   type = string
# }

variable "content_version" {
  type = number  
}

# variable "assets_path" {
#   description = "Path for public assets folder"
#   type = string
# }

variable "terratowns_access_token" {
  description = "Terratowns Access Token"
  type = string  
}

variable "terratowns_endpoint" {
  description = "Terratowns endpoint"
  type = string  
}
