terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

#   cloud {
#     organization = "TerraCamp"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# module "terrahouse_aws" {
#   source = "./modules/terrahouse-aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }

resource "terratowns_home" "home" {
  name = "Best noir comuter games. Mafia. L.A. Noir and other games."
  description = <<DESCRIPTION
The noir genre arose in film during and after World War II. 
It featured cynical motivations and dramatic depictions of crime, 
which reflected that of life post-war. 
Its rise gave us some of the genre's earliest films like The 
Maltese Falcon and Laura, both of which were detective-based films, 
which is why crime and detective work have often featured as part of the noir premise. 
However, the genre has since spread to a variety of mediums, including video games. 
Now there are numerous games that classify in the noir genre
DESCRIPTION
  domain_name =  "3eqdda2.cloudfront.net" # module.terrahouse_aws.cloudfront_url
  town = "gamers-grotto"
  content_version = 1
}
