module "security_group" {
  source = "./modules/security_group"

  aws_region  = var.aws_region
  vpc_id      = module.vpc.vpc_id
  custom_tags = var.custom_tags

  elb_ingress = [
    {
      from_port   = "443"
      to_port     = "443"
      protocol    = "tcp"
      description = "HTTPS Application access from world-wide"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  elb_egress = [
    {
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      description = "Application access to world-wide"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  app_ingress = [
    {
      from_port   = "3000"
      to_port     = "3009"
      protocol    = "tcp"
      description = "Application Port. Access from all private networks"
      cidr_blocks = var.vpc_private_subnet_ip_ranges
    },
  ]

  app_egress = [
    {
      from_port   = "3306"
      to_port     = "3306"
      protocol    = "tcp"
      description = "Access to DB"
      cidr_blocks = [
        var.vpc_private_subnet_ip_ranges[2],
        var.vpc_private_subnet_ip_ranges[3],
      ]
    },
  ]

  efs_ingress = [
    {
      from_port   = "2049"
      to_port     = "2049"
      protocol    = "tcp"
      description = "EFS access from the application subnets."
      cidr_blocks = var.vpc_private_subnet_ip_ranges
    },
  ]

  efs_egress = [
    {
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      description = "EFS access to the application subnets."
      cidr_blocks = [
        var.vpc_private_subnet_ip_ranges[2],
        var.vpc_private_subnet_ip_ranges[3],
      ]
    },
  ]

  cloud_front_ingress = [
    {
      from_port   = "443"
      to_port     = "443"
      protocol    = "tcp"
      description = "CloudFront listening port"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  cloud_front_egress = [
    {
      from_port   = "3000"
      to_port     = "3009"
      protocol    = "tcp"
      description = "Application Port (thin). Access to local networks and the World"
      cidr_blocks = [
        var.vpc_private_subnet_ip_ranges,
        "0.0.0.0/0",
      ]
    },
  ]

  elasticache_ingress = [
    {
      from_port   = "11211"
      to_port     = "11211"
      protocol    = "tcp"
      description = "ElastiCache access from the application subnets"
      cidr_blocks = [
        var.vpc_private_subnet_ip_ranges[0],
        var.vpc_private_subnet_ip_ranges[1],
      ]
    },
  ]

  elasticache_egress = [
    {
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      description = "ElastiCache access to the application subnets"
      cidr_blocks = [
        var.vpc_private_subnet_ip_ranges[0],
        var.vpc_private_subnet_ip_ranges[1],
      ]
    },
  ]

  db_ingress = [
    {
      from_port   = "3306"
      to_port     = "3306"
      protocol    = "tcp"
      description = "DB access from the application subnets."
      cidr_blocks = [
        var.vpc_private_subnet_ip_ranges[0],
        var.vpc_private_subnet_ip_ranges[1],
      ]
    },
  ]

  db_egress = [
    {
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      description = "DB access to the application subnets."
      cidr_blocks = [
        var.vpc_private_subnet_ip_ranges[0],
        var.vpc_private_subnet_ip_ranges[1],
      ]
    },
  ]
}
