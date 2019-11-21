module "autoscaling_group_app_server" {
  source = "./modules/autoscaling_group"

  ec2_name           = "${var.custom_tags["Name"]}-app-server"
  ec2_ami_image      = "ami-00e8b55a2e841be44"
  ec2_instance_type  = "t2.micro"
  ec2_key_name       = var.ec2_key_name
  security_groups_id = [module.security_group.app_id]
  custom_tags        = var.custom_tags
  efs_id             = module.efs.efs_id
  ec2_iam_role       = aws_iam_instance_profile.AmazonEC2ApplicationRole.name
  efs_mount_point    = "/mnt/efs"

  app_subnets_id = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1],
  ]

  load_balancer_arn   = module.load_balancer_app_server.arn
  app_min_size        = 2
  app_max_size        = 10
  health_check_period = 300
}
