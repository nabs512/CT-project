

resource "aws_elb" "app_lb" {
  name               = "web-server-lb"
  availability_zones = ["ap-south-1a" , "ap-south-1b"]

listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

}

# Optional Target Group for future Auto Scaling integration
resource "aws_lb_target_group" "web_server_tg" {
  name     = "web-server-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    port                 = 80
    interval             = 30
    timeout              = 5
    healthy_threshold     = 2
    unhealthy_threshold = 5
  }
}

output "dns_name" {
  value = aws_elb.app_lb.dns_name
}
