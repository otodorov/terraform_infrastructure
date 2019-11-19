variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type        = string
}

variable "vpc_domain_name" {
  description = "VPC domain name for the DHCP option set"
  type        = string
}

variable "default_tags" {
  description = "Default tags for all recources"
  type        = map
  default = {
    Terraform = "true",
  }
}

variable "custom_tags" {
  description = "Custom tags for all recources"
  type        = map
  default     = {}
}

variable "vpc_availability_zones" {
  description = "AWS Availability Zones"
  type        = list
}

variable "vpc_public_subnet_ip_ranges" {
  description = "VPC public subnets IP ranges"
  type        = list
}

variable "vpc_public_subnet_tags" {
  description = "VPC public subnets tags"
  type        = list
}

variable "vpc_private_subnet_ip_ranges" {
  description = "VPC private subnets IP ranges"
  type        = list
}

variable "vpc_private_subnet_tags" {
  description = "VPC private subnets tags"
  type        = list
}
