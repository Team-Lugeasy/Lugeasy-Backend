// [GET] /api
resource "aws_api_gateway_resource" "root_resource" {
  rest_api_id = aws_api_gateway_rest_api.root.id
  parent_id   = aws_api_gateway_rest_api.root.root_resource_id
  path_part   = "api"
}

resource "aws_api_gateway_method" "get_root_method" {
  rest_api_id   = aws_api_gateway_rest_api.root.id
  resource_id   = aws_api_gateway_resource.root_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_root_integration" {
  rest_api_id             = aws_api_gateway_rest_api.root.id
  resource_id             = aws_api_gateway_resource.root_resource.id
  http_method             = aws_api_gateway_method.get_root_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.main_handler_invoke_arn
}