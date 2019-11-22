module "elasticache_app_server" {
  source = "./modules/elasticache"

  cluster_id                     = "${var.custom_tags["Name"]}-elasticache"
  replication_group_description  = "${var.custom_tags["Name"]} elasticache cluster"
  engine_version                 = "5.0.5"
  num_cache_nodes                = "2"
  parameter_group_name           = "elasticache-parameters"
  elasticache_port               = "6379"
  elasticache_instance_type      = "cache.t2.micro"
  elasticache_security_groups_id = module.security_group.elasticache_id
  vpc_availability_zones         = var.vpc_availability_zones
  backup_window                  = "07:00-09:00"
  backup_retention_period        = 5

  db_subnets = [
    module.vpc.private_subnets[2],
    module.vpc.private_subnets[3],
  ]

  custom_tags = var.custom_tags
}

output "REDIS_endpoint" {
  value = "${module.elasticache_app_server.endpoint}:${module.elasticache_app_server.port}"
}
