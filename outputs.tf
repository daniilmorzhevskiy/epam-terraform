output "launch_template_id" {
  value = aws_launch_template.this.id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.this.name
}

output "load_balancer_dns" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}