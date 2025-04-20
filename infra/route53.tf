resource "aws_route53_record" "api_alias" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "api.lugeasy.com"
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.api_domain.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api_domain.regional_zone_id
    evaluate_target_health = true
  }
}
