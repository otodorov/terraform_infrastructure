resource "aws_elasticache_subnet_group" "elasticache" {
  name        = var.custom_tags["Name"]
  description = "Private subnets for the ElastiCache instances: ${var.custom_tags["Name"]}"
  subnet_ids  = var.db_subnets
}

resource "aws_elasticache_parameter_group" "elasticache" {
  name        = "${var.custom_tags["Name"]}-${var.parameter_group_name}"
  family      = "redis${join(".", slice(split(".", var.engine_version), 0, 2))}"
  description = "The parameter group for ${var.custom_tags["Name"]}"
}

resource "aws_elasticache_replication_group" "elasticache" {
  replication_group_description = var.replication_group_description
  automatic_failover_enabled    = true
  availability_zones            = var.vpc_availability_zones
  replication_group_id          = "${var.cluster_id}rep"
  node_type                     = var.elasticache_instance_type
  number_cache_clusters         = var.num_cache_nodes
  parameter_group_name          = aws_elasticache_parameter_group.elasticache.name
  transit_encryption_enabled    = true
  at_rest_encryption_enabled    = true
  engine_version                = var.engine_version
  port                          = var.elasticache_port
  subnet_group_name             = aws_elasticache_subnet_group.elasticache.name
  security_group_ids            = [var.elasticache_security_groups_id]
  snapshot_window               = var.backup_window
  snapshot_retention_limit      = var.backup_retention_period
  tags                          = merge(var.default_tags, var.custom_tags, { "Name" = var.cluster_id })
}
