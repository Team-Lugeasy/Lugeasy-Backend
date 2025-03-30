
# ----------------------------
# 1. 루트 도메인 (lugeasy.com) Hosted Zone
# ----------------------------
resource "aws_route53_zone" "main" {
  name = "lugeasy.com"
}

# ----------------------------
# 2. 서브도메인 (api.lugeasy.com) 위임용 Hosted Zone
# ----------------------------
resource "aws_route53_zone" "api" {
  name = "api.lugeasy.com"

  tags = {
    Environment = "api"
  }
}

# ----------------------------
# 3. 루트 도메인에서 서브도메인 위임 (NS)
# ----------------------------
resource "aws_route53_record" "api_ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.lugeasy.com"
  type    = "NS"
  ttl     = 300
  records = aws_route53_zone.api.name_servers
}

# ----------------------------
# 4. ACM 인증서 요청 (api.lugeasy.com)
# ----------------------------
resource "aws_acm_certificate" "lugeasy" {
  domain_name       = "api.lugeasy.com"
  validation_method = "DNS"
  # 기존 인증서를 제거하고 새로운 인증서를 생성 (옵셔널 -> 필수는 아닌듯 함) 
  lifecycle {
    create_before_destroy = true
  }
}

# ----------------------------
# 5. ACM 검증용 DNS 레코드 생성 (CNAME)
# ----------------------------
resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.lugeasy.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  zone_id = aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

# ----------------------------
# 6. ACM 인증서 검증 완료 처리
# ----------------------------
resource "aws_acm_certificate_validation" "lugeasy" {
  certificate_arn         = aws_acm_certificate.lugeasy.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}

# ----------------------------
# 7. API Gateway 사용자 지정 도메인 생성
# ----------------------------
resource "aws_api_gateway_domain_name" "lugeasy" {
  domain_name              = "api.lugeasy.com"
  regional_certificate_arn = aws_acm_certificate_validation.lugeasy.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# ----------------------------
# 8. 사용자 지정 도메인을 api.lugeasy.com에 연결 (A 레코드)
# ----------------------------
resource "aws_route53_record" "lugeasy_alias" {
  depends_on = [aws_api_gateway_domain_name.lugeasy]

  zone_id = aws_route53_zone.api.zone_id
  name    = "api.lugeasy.com"
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.lugeasy.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.lugeasy.regional_zone_id
    evaluate_target_health = true
  }
}