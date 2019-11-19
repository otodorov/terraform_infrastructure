module "load_balancer_app_server" {
  source = "./modules/load_balancer"

  vpc_id            = module.vpc.vpc_id
  elb_name          = "${var.custom_tags["Name"]}-app-server-ALB"
  app_port          = "3000"
  app_protocol      = "HTTP"
  elb_port          = "443"
  elb_protocol      = "HTTPS"
  app_ASG_id        = module.autoscaling_group_app_server.asg_id
  private_key       = "todorov_ltd.key"
  certificate_body  = "todorov_ltd.crt"
  certificate_chain = "letsencryptauthorityx3.pem"

  elb_subnets = flatten([
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1],
  ])
  security_groups_id = [module.security_group.elb_id]
  internal           = true
  custom_tags        = var.custom_tags
}

module "autoscaling_group_app_server" {
  source = "./modules/autoscaling_group"

  ec2_name           = "${var.custom_tags["Name"]}-app-server"
  ec2_ami_image      = "ami-00e8b55a2e841be44"
  ec2_instance_type  = "t2.micro"
  ec2_key_name       = var.ec2_key_name
  security_groups_id = [module.security_group.app_id]
  custom_tags        = var.custom_tags

  app_subnets_id = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1],
  ]

  load_balancer_arn   = module.load_balancer_app_server.load_balancer_arn
  app_min_size        = 2
  app_max_size        = 10
  health_check_period = 300
}
