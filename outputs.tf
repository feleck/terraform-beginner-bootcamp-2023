output "bucket_name" {
  description = "Bucket name for static website hosting"
  value = module.home_games_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value = module.home_games_hosting.website_endpoint
}

output "domain_name" {
  description = "The Cloudfront Distribution Domain Name"
  value = module.home_games_hosting.domain_name
}
