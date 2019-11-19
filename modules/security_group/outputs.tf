output "elb_id" {
  value = aws_security_group.elb.id
}

output "app_id" {
  value = aws_security_group.app.id
}

output "efs_id" {
  value = aws_security_group.efs.id
}

output "db_id" {
  value = aws_security_group.db.id
}

output "elasticache_id" {
  value = aws_security_group.elasticache.id
}

output "cloudfront_id" {
  value = aws_security_group.cloudfront.id
}
