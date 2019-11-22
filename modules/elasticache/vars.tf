variable elasticache_security_groups_id {}
variable replication_group_description {}
variable elasticache_instance_type {}
variable num_cache_nodes {}
variable parameter_group_name {}
variable elasticache_port {}
variable cluster_id {}
variable engine_version {}

variable db_subnets {
  type = list(string)
}

variable vpc_availability_zones {
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
