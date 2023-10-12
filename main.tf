terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

  cloud {
    organization = "TerraCamp"

    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_games_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.games.public_path
  # index_html_filepath = var.index_html_filepath
  # error_html_filepath = var.error_html_filepath
  # assets_path = var.assets_path
  content_version = var.games.content_version
}

resource "terratowns_home" "home_games_hosting" {
  name = "Best noir comuter games. Mafia. L.A. Noir and other games."
  description = <<DESCRIPTION
The noir genre arose in film during and after World War II. 
It featured cynical motivations and dramatic depictions of crime, 
which reflected that of life post-war. 
Its rise gave us some of the genre's earliest films like The 
Maltese Falcon and Laura, both of which were detective-based films, 
which is why crime and detective work have often featured as part of the noir premise. 
However, the genre has since spread to a variety of mediums, including video games. 
Now there are numerous games that classify in the noir genre.
DESCRIPTION
  # domain_name =  "3eqdda2.cloudfront.net" 
  domain_name = module.home_games_hosting.domain_name
  town = "gamers-grotto"
  content_version = var.games.content_version
}

module "home_movies_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.movies.public_path
  # index_html_filepath = var.index_html_filepath
  # error_html_filepath = var.error_html_filepath
  # assets_path = var.assets_path
  content_version = var.movies.content_version
}

resource "terratowns_home" "home_movies" {
  name = "Best noir movies."
  description = <<DESCRIPTION
film noir, (French: “dark film”) style of filmmaking 
characterized by such elements as cynical heroes, 
stark lighting effects, frequent use of flashbacks, 
intricate plots, and an underlying existentialist philosophy
DESCRIPTION
  # domain_name =  "3eqdda2.cloudfront.net" 
  domain_name = module.home_movies_hosting.domain_name
  town = "video-valley"
  content_version = var.movies.content_version
}
