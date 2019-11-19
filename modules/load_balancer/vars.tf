variable "vpc_id" {}
variable "elb_name" {}
variable "elb_port" {}
variable "elb_protocol" {}
variable "app_port" {}
variable "app_protocol" {}
variable "app_ASG_id" {}
variable "security_groups_id" {}

variable "private_key" {
  description = "The certificate's PEM-formatted private key"
}

variable "certificate_body" {
  description = "The certificate's PEM-formatted public key"
}

variable "certificate_chain" {
  description = "The certificate's PEM-formatted chain"
}

variable "elb_subnets" {
  type = list(string)
}

variable "internal" {
  default = true
}

variable "default_tags" {
  type = map(string)
  default = {
    "Terraform" = "true"
  }
}

variable "custom_tags" {}
