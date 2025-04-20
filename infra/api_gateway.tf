// root api 
resource "aws_api_gateway_rest_api" "root" {
  name        = "RootAPI"
  description = "API Gateway for root"
}

// root api 
resource "aws_api_gateway_resource" "root_resource" {
  rest_api_id = aws_api_gateway_rest_api.root.id
  parent_id   = aws_api_gateway_rest_api.root.root_resource_id
  path_part   = "api"
}

// [GET] /api
resource "aws_api_gateway_method" "get_root" {
  rest_api_id   = aws_api_gateway_rest_api.root.id
  resource_id   = aws_api_gateway_resource.root_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "get_root" {
  rest_api_id   = aws_api_gateway_rest_api.root.id
  resource_id   = aws_api_gateway_resource.user_resource.id
  http_method   = aws_api_gateway_method.get_root.http_method
  status_code   = "200"
}

resource "aws_api_gateway_integration" "get_root_integration" {
  rest_api_id             = aws_api_gateway_rest_api.root.id
  resource_id             = aws_api_gateway_resource.root_resource.id
  http_method             = aws_api_gateway_method.get_root.http_method
  integration_http_method = "POST" 
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main_handler.invoke_arn
}

// user api 
resource "aws_api_gateway_resource" "user_resource" {
  rest_api_id = aws_api_gateway_rest_api.root.id
  parent_id   = aws_api_gateway_resource.root_resource.id
  path_part   = "user"
}

// [GET] /api/user
resource "aws_api_gateway_method" "get_user" {
  rest_api_id   = aws_api_gateway_rest_api.root.id
  resource_id   = aws_api_gateway_resource.user_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "get_user" {
  rest_api_id   = aws_api_gateway_rest_api.root.id
  resource_id   = aws_api_gateway_resource.user_resource.id
  http_method   = aws_api_gateway_method.get_user.http_method
  status_code   = "200"
}

resource "aws_api_gateway_integration" "get_user_integration" {
  rest_api_id             = aws_api_gateway_rest_api.root.id
  resource_id             = aws_api_gateway_resource.user_resource.id
  http_method             = aws_api_gateway_method.get_user.http_method
  integration_http_method = "POST" 
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main_handler.invoke_arn
}

// [POST] /api/user
resource "aws_api_gateway_method" "post_user" {
  rest_api_id   = aws_api_gateway_rest_api.root.id
  resource_id   = aws_api_gateway_resource.user_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "post_user" {
  rest_api_id   = aws_api_gateway_rest_api.root.id
  resource_id   = aws_api_gateway_resource.user_resource.id
  http_method   = aws_api_gateway_method.post_user.http_method
  status_code   = "200"
}

resource "aws_api_gateway_integration" "post_user_integration" {
  rest_api_id             = aws_api_gateway_rest_api.root.id
  resource_id             = aws_api_gateway_resource.user_resource.id
  http_method             = aws_api_gateway_method.post_user.http_method
  integration_http_method = "POST" 
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main_handler.invoke_arn
}

// apigateway의 람다 접근권한 설정
resource "aws_lambda_permission" "api_gateway_main_handler" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main_handler.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.root.execution_arn}/*/*"
}

// api 배포
resource "aws_api_gateway_deployment" "root" {
  rest_api_id = aws_api_gateway_rest_api.root.id

  depends_on = [
    aws_api_gateway_integration.get_root_integration,
    aws_api_gateway_integration.get_user_integration,
    aws_api_gateway_integration.post_user_integration,
  ]
}

resource "aws_api_gateway_stage" "dev" {
  deployment_id = aws_api_gateway_deployment.root.id
  rest_api_id   = aws_api_gateway_rest_api.root.id
  stage_name    = "dev"
}