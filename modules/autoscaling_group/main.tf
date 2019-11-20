data "template_file" "user_data" {
  template = file("./scripts/user_data_app.sh")

  vars = {
    custom_hostname = var.custom_tags["Name"]
    efs_id          = var.efs_id
  }
}

resource "aws_launch_configuration" "app" {
  name_prefix          = "${var.ec2_name}-"
  image_id             = var.ec2_ami_image
  instance_type        = var.ec2_instance_type
  key_name             = var.ec2_key_name
  user_data            = data.template_file.user_data.rendered
  security_groups      = var.security_groups_id
  iam_instance_profile = var.ec2_iam_role

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
  name_prefix               = "${var.ec2_name}-"
  vpc_zone_identifier       = var.app_subnets_id
  launch_configuration      = aws_launch_configuration.app.name
  target_group_arns         = [var.load_balancer_arn]
  min_size                  = var.app_min_size
  max_size                  = var.app_max_size
  health_check_grace_period = var.health_check_period
  health_check_type         = "ELB"
  force_delete              = true

  dynamic "tag" {
    for_each = merge(var.custom_tags, { "Name" = var.ec2_name })

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
