# Request an ACM certificate for your domain
resource "aws_acm_certificate" "domain_cert" {
  domain_name = "mydummydomain.com"  
  validation_method = "DNS" 
}

# get the hosted zone ID from Route 53 
data "aws_route53_zone" "main_zone" {
  name = aws_route53_zone.main.name  # We can Reference our Route 53 zone name
}

# ACM Certificate Validation - Route 53 DNS Record
resource "aws_acm_certificate_validation" "domain_validation" {
  certificate_arn = aws_acm_certificate.domain_cert.arn
  validation_record_fqdns = aws_acm_certificate.domain_cert.validation_record_fqdns

  timeouts {
    create = "5m"
  }
}

# Linking the ACM certificate with the ELB
resource "aws_lb_listener" "app_lb_listener" {
  port               = 443  # HTTPS 
  certificate_arn    = aws_acm_certificate.domain_cert.arn
  ssl_policy         = "ELB-1.2-Suite"
  load_balancer_arn = aws_lb.app_lb.id

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_server_tg.arn
  }
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.domain_cert.arn
}
