variable "ec2_name" {
  description = "Name prefix for AutoScaling"
  type        = string
}
variable "app_subnets_id" {
  type = list(string)
}

variable "default_tags" {
  type = list(any)
  default = [
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    },
  ]
}

variable "custom_tags" {
  description = "Custom tags for all recources"
  type        = map
}
