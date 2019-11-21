output "arn" {
  value = aws_lb_target_group.load_balancer.arn
}

output "dns_name" {
  value = aws_lb.load_balancer.dns_name
}
