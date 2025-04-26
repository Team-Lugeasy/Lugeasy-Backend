data "template_file" "lugeasy_api_swagger" {
  template = file("${path.module}/../swagger.yaml")
}

resource "aws_api_gateway_rest_api" "swagger" {
  name        = "swagger api"
  description = "Lugeasy API Gateway"
  body        = data.template_file.lugeasy_api_swagger.rendered
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "prod" {
  rest_api_id = aws_api_gateway_rest_api.swagger.id
}