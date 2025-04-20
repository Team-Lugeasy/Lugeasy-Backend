# resource "aws_acm_certificate" "api_cert" {
#   domain_name       = "api.lugeasy.com"
#   validation_method = "DNS"

#   lifecycle {
#     prevent_destroy = true # 실수로 삭제 방지
#   }
# }

# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.api_cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record  = dvo.resource_record_value
#     }
#   }

#   allow_overwrite = true
#   zone_id = data.aws_route53_zone.main.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   ttl     = 60
#   records = [each.value.record]
# }

# resource "aws_acm_certificate_validation" "api_cert_validation" {
#   certificate_arn = aws_acm_certificate.api_cert.arn

#   validation_record_fqdns = [
#     for record in aws_route53_record.cert_validation : record.fqdn
#   ]
# }

