resource "aws_efs_file_system" "app" {
  creation_token   = var.efs_name
  encrypted        = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} Application server EFS" },
  )
}

resource "aws_efs_mount_target" "app" {
  count           = length(var.app_subnets_id)
  file_system_id  = aws_efs_file_system.app.id
  subnet_id       = var.app_subnets_id[count.index]
  security_groups = var.security_groups_id
}
