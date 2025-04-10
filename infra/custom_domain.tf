# resource "aws_api_gateway_domain_name" "api_domain" {
#   domain_name              = "api.lugeasy.com"
#   regional_certificate_arn = aws_acm_certificate.api_cert.arn

#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# resource "aws_api_gateway_base_path_mapping" "default" {
#   api_id      = aws_api_gateway_rest_api.root.id
#   stage_name  = aws_api_gateway_stage.dev.stage_name
#   domain_name = aws_api_gateway_domain_name.api_domain.domain_name
# }
