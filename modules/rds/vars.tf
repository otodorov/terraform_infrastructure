variable vpc_availability_zones {
  description = "AWS Availability Zones"
  type        = list
}
variable rds_name {}
variable db_instance_count {}
variable rds_instance_type {}
variable db_name {}
variable master_username {}
variable master_password {}
variable engine {}
variable engine_version {}
variable backup_window {}
variable backup_retention_period {}
variable vpc_security_group_ids {}
variable db_subnet_group {
  type = list
}
variable default_tags {
  description = "Default tags for all recources"
  type        = map
  default = {
    Terraform = "true",
  }
}

variable custom_tags {
  description = "Custom tags for all recources"
  type        = map
  default     = {}
}
