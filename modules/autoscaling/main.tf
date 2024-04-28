

resource "aws_autoscaling_group" "web_server_asg" {
  name = "web-server-asg"
  vpc_zone_identifier = aws_subnet.public.subnet_id 

  # Launch Configuration Reference
  launch_configuration = var.launch_configuration_name

  # Auto Scaling Group Configuration
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity

  # Health Check Configuration (references ELB target group)
  health_check_type    = "ELB"
  health_check_grace_period = 300
}

output "asg_name" {
  value = aws_autoscaling_group.web_server_asg.name
}
