resource "aws_s3_bucket" "cloudfront_bucket" {
  bucket = lower(var.cloudfront_bucket_name)
  acl    = "private"

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }

  tags = merge(var.default_tags, var.custom_tags, { "Name" = var.cloudfront_distribution_name })
}

resource "aws_s3_bucket_public_access_block" "cloudfront_bucket_nopub" {
  bucket = aws_s3_bucket.cloudfront_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "cloudfront_bucket_policy" {
  bucket = aws_s3_bucket.cloudfront_bucket.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": { "AWS": "${aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.iam_arn}" },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.cloudfront_bucket.arn}/*"
        }
    ]
}
POLICY

}

