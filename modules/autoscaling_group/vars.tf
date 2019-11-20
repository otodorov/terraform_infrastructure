variable security_groups_id {}
variable load_balancer_arn {}
variable app_min_size {}
variable app_max_size {}
variable health_check_period {}
variable efs_id {}
variable ec2_iam_role {}

variable ec2_name {
  description = "Name prefix for AutoScaling"
  type        = string
}

variable ec2_ami_image {
  description = "AMI image for current region"
  type        = string
}

variable ec2_instance_type {
  description = "Type of EC2 instance"
  type        = string
}

variable ec2_key_name {
  description = "Key pair name. This parameter is not required."
  type        = string
  default     = null
}

variable app_subnets_id {
  type = list(string)
}

variable default_tags {
  type = list(any)
  default = [
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    },
  ]
}

variable custom_tags {
  description = "Custom tags for all recources"
  type        = map
}
