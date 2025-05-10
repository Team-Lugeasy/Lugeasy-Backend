// auth
resource "aws_api_gateway_resource" "auth_resource" {
  rest_api_id = aws_api_gateway_rest_api.root.id
  parent_id   = aws_api_gateway_resource.root_resource.id
  path_part   = "auth"
}

// [POST] /api/auth/login
resource "aws_api_gateway_resource" "login_resource" {
  rest_api_id = aws_api_gateway_rest_api.root.id
  parent_id   = aws_api_gateway_resource.auth_resource.id
  path_part   = "login"
}

resource "aws_api_gateway_method" "login_method" {
  rest_api_id   = aws_api_gateway_rest_api.root.id
  resource_id   = aws_api_gateway_resource.login_resource.id
  http_method   = "POST"
  authorization = "NONE"
  request_parameters = { "method.request.querystring.social" = true }
}

resource "aws_api_gateway_integration" "login_integration" {
  rest_api_id             = aws_api_gateway_rest_api.root.id
  resource_id             = aws_api_gateway_resource.login_resource.id
  http_method             = aws_api_gateway_method.login_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.main_handler_invoke_arn
}