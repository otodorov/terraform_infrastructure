variable efs_name {
  description = "Name prefix for AutoScaling"
  type        = string
}
variable app_subnets_id {
  type = list(string)
}

variable default_tags {
  type = map(string)
  default = {
    "Terraform" = "true"
  }
}

variable custom_tags {
  type = map(string)
}
variable security_groups_id {}
