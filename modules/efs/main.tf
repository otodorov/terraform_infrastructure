resource "aws_efs_file_system" "app" {
  creation_token   = "${var.ec2_name}-application-EFS"
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
  file_system_id = aws_efs_file_system.app.id
  subnet_id = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1],
  ]
  security_groups = module.security_groups.efs
}
