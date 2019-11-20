module "efs" {
  source = "./modules/efs"

  efs_name    = "${var.custom_tags["Name"]}-application-EFS"
  custom_tags = var.custom_tags
  app_subnets_id = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1],
  ]
  security_groups_id = [module.security_group.efs_id]
}
