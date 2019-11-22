variable aws_region {
  description = "AWS region to use by default"
}

variable cloudfront_bucket_name {
  description = "Cloudfront bucket name."
}

variable cloudfront_s3_origin_id {
  description = "S3 origin id"
}

variable default_cache_min_ttl {
  description = "Default CF cache behavior min_ttl."
}

variable default_cache_default_ttl {
  description = "Default CF cache behavior default_ttl."
}

variable default_cache_max_ttl {
  description = "Default CF cache behavior max_ttl."
}

variable cloudfront_distribution_name {
  description = "Name tag for the CF distribution name."
}

variable default_tags {
  description = "Default tags for all recources"
  type        = map
  default = {
    Terraform = "true",
  }
}

variable custom_tags {
  description = "Custom tags for all recources"
  type        = map
  default     = {}
}
