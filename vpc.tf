module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block               = var.vpc_cidr_block
  aws_region                   = var.aws_region
  vpc_availability_zones       = var.vpc_availability_zones
  vpc_domain_name              = "${var.custom_tags["Name"]}.${var.vpc_domain_name}"
  vpc_public_subnet_tags       = var.vpc_public_subnet_tags
  vpc_public_subnet_ip_ranges  = var.vpc_public_subnet_ip_ranges
  vpc_private_subnet_tags      = var.vpc_private_subnet_tags
  vpc_private_subnet_ip_ranges = var.vpc_private_subnet_ip_ranges
  custom_tags                  = var.custom_tags
  vpc_tags                     = var.vpc_tags
}
