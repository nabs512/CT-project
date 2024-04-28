# Reference the ELB module output for DNS name
data "aws_elb" "app_lb" {
  name = aws_elb.app_lb.name
}

resource "aws_route53_zone" "main" {
  name = "mydummydomain.com"  # Replace with your domain name
}

# Route 53 Record - Point to ELB DNS Name
resource "aws_route53_record" "www_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www." + aws_route53_zone.main.name
  type    = "A"

  alias {
    name = data.aws_elb.app_lb.dns_name
    zone_id = aws_elb.app_lb.zone_id  # Ensure zone matches ELB zone
    evaluate_target_health = true
  }
}

output "hosted_zone_id" {
  value = aws_route53_zone.main.zone_id
}
