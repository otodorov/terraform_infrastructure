variable aws_region {
  description = "AWS region"
  type        = string
}

variable aws_profile {
  description = "AWS profile"
  type        = string
}

variable aws_credentials_file {
  description = "AWS credentials file"
  type        = string
}

variable vpc_availability_zones {}
variable vpc_domain_name {}
variable vpc_cidr_block {}
variable vpc_private_subnet_ip_ranges {}
variable vpc_private_subnet_tags {}
variable vpc_public_subnet_ip_ranges {}
variable vpc_public_subnet_tags {}
variable custom_tags {}
variable ec2_key_name {
  description = "Key pair name. This parameter is not required."
  type        = string
  default     = ""
}
variable ec2_attach_role {
  type        = list(string)
  description = "IAM Role for Application EC2 Instances"
  default = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess",
  ]
}
