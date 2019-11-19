resource "aws_lb" "load_balancer" {
  name                       = var.elb_name
  internal                   = var.internal
  load_balancer_type         = "application"
  subnets                    = var.elb_subnets
  enable_deletion_protection = false
  security_groups            = var.security_groups_id

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.default_tags, var.custom_tags, { "Name" = var.elb_name })
}

resource "aws_lb_target_group" "load_balancer" {
  name     = var.elb_name
  port     = var.app_port
  protocol = var.app_protocol
  vpc_id   = var.vpc_id
  tags     = merge(var.default_tags, var.custom_tags, { "Name" = var.elb_name })
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = var.elb_port
  protocol          = var.elb_protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer.arn
  }
}

