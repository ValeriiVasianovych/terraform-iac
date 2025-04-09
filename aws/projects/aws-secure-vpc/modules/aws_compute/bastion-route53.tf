# # http
# # resource "aws_route53_record" "vpn_domain_record" {
# #   zone_id = var.hosted_zone_id
# #   name    = var.hosted_zone_name
# #   type    = "A"
  
# #   alias {
# #     name                   = aws_lb.private_instance_alb[0].dns_name
# #     zone_id                = aws_lb.private_instance_alb[0].zone_id
# #     evaluate_target_health = true                                    
# #   }
  
# #   depends_on = [aws_lb.private_instance_alb]
# # }

# # https
# resource "aws_acm_certificate" "vpn_domain_cert" {
#   domain_name       = "vpn.${var.hosted_zone_name}"
#   validation_method = "DNS"
  
#   # subject_alternative_names = ["app.${var.hosted_zone_name}"]  # Modified to include wildcard if needed
  
#   tags = {
#     Name = "${var.env}-vpn-certificate"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_route53_record" "vpn_cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.vpn_domain_cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = var.hosted_zone_id
# }

# resource "aws_acm_certificate_validation" "vpn_cert" {
#   certificate_arn         = aws_acm_certificate.vpn_domain_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.vpn_cert_validation : record.fqdn]
# }

# resource "aws_route53_record" "vpn_domain_record" {
#   zone_id = var.hosted_zone_id
#   name    = "vpn.${var.hosted_zone_name}"
#   type    = "A"
  
#   alias {
#     name                   = aws_lb.public_instance_alb[0].dns_name
#     zone_id                = aws_lb.public_instance_alb[0].zone_id
#     evaluate_target_health = true
#   }
  
#   depends_on = [aws_lb.private_instance_alb]
# }