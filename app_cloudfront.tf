module "cloudfront_app_server" {
  source = "./modules/cloudfront"

  aws_region                   = var.aws_region
  cloudfront_distribution_name = "${var.custom_tags["Name"]}-app-server"
  cloudfront_bucket_name       = "${var.custom_tags["Name"]}-app-server"
  cloudfront_s3_origin_id      = "S3-${var.custom_tags["Name"]}-app-server"
  default_cache_min_ttl        = 0
  default_cache_default_ttl    = 0
  default_cache_max_ttl        = 0
  custom_tags                  = var.custom_tags
}

output "CloudFront_domain" {
  value = module.cloudfront_app_server.domain
}
