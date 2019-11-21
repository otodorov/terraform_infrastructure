module "rds_app_server" {
  source = "./modules/rds"

  db_instance_count       = 2
  rds_name                = "${var.custom_tags["Name"]}-app"
  db_name                 = var.custom_tags["Name"]
  rds_instance_type       = "db.t2.small"
  vpc_availability_zones  = var.vpc_availability_zones
  master_username         = "Administrator"
  master_password         = "0w0hScaWFiBIYaBM"
  engine                  = "aurora"
  engine_version          = "5.6.10a"
  backup_window           = "07:00-09:00"
  backup_retention_period = 5
  vpc_security_group_ids  = [module.security_group.db_id]
  db_subnet_group = [
    module.vpc.private_subnets[2],
    module.vpc.private_subnets[3],
  ]

  custom_tags = var.custom_tags
}

output "RDS_cluster_address" {
  value = module.rds_app_server.cluster_address
}
