resource "aws_db_subnet_group" "rds" {
  name_prefix = "${lower(var.rds_name)}-"
  description = "DB subnet for ${var.rds_name}"
  subnet_ids  = var.db_subnet_group
}

resource "aws_rds_cluster" "rds" {
  cluster_identifier_prefix = "${lower(var.rds_name)}-cluster-"
  database_name             = lower(var.db_name)
  master_username           = var.master_username
  master_password           = var.master_password
  engine                    = var.engine
  engine_version            = var.engine_version
  db_subnet_group_name      = aws_db_subnet_group.rds.name
  storage_encrypted         = true
  skip_final_snapshot       = false
  #final_snapshot_identifier = "${lower(var.rds_name)}-cluster-final-snapshot"
  final_snapshot_identifier = "${lower(var.db_name)}-cluster-final-snapshot-${formatdate("DDMMMYYYYhhmmss", timestamp())}"

  tags = merge(var.default_tags, var.custom_tags, { "Name" = var.rds_name })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_rds_cluster_instance" "rds" {
  count                = length(var.vpc_availability_zones)
  identifier_prefix    = "${lower(var.rds_name)}-${count.index}-"
  cluster_identifier   = aws_rds_cluster.rds.id
  instance_class       = var.rds_instance_type
  db_subnet_group_name = aws_db_subnet_group.rds.name

  lifecycle {
    create_before_destroy = true
  }
}
