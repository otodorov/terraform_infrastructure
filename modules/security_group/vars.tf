variable "aws_region" {}
variable "vpc_id" {}
variable "default_tags" {
  type = map(string)
  default = {
    "Terraform" = "true"
  }
}

variable "custom_tags" {
  description = "Custom tags for all recources"
  type        = map(string)
}

variable "elb_ingress" {
  type = list
}

variable "elb_egress" {
  type = list
}

variable "app_ingress" {
  type = list
}

variable "app_egress" {
  type = list
}

variable "cloud_front_ingress" {
  type = list
}

variable "cloud_front_egress" {
  type = list
}

variable "elasticache_ingress" {
  type = list
}

variable "elasticache_egress" {
  type = list
}

variable "db_ingress" {
  type = list
}

variable "db_egress" {
  type = list
}
