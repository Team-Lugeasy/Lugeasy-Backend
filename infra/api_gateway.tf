// API gateway 생성
resource "aws_api_gateway_rest_api" "root_api" {
  name        = "RootAPI"
  description = "API Gateway for root"
}

# 경로지정 /api
resource "aws_api_gateway_resource" "root_resource" {
  rest_api_id = aws_api_gateway_rest_api.root_api.id
  parent_id   = aws_api_gateway_rest_api.root_api.root_resource_id
  path_part   = "api"
}

# 경로지정 /api/user
resource "aws_api_gateway_resource" "user_resource" {
  rest_api_id = aws_api_gateway_rest_api.root_api.id
  parent_id   = aws_api_gateway_resource.root_resource.id
  path_part   = "user"
}

// method 지정 /api/user GET
resource "aws_api_gateway_method" "user_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.root_api.id
  resource_id   = aws_api_gateway_resource.user_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

// method 지정 /api/user POST
resource "aws_api_gateway_method" "user_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.root_api.id
  resource_id   = aws_api_gateway_resource.user_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

// 람다와 연결 /api/user GET
resource "aws_api_gateway_integration" "user_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.root_api.id
  resource_id             = aws_api_gateway_resource.user_resource.id
  http_method             = aws_api_gateway_method.user_get_method.http_method
  integration_http_method = "POST" # Lambda는 POST 메서드를 사용합니다.
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main_handler.invoke_arn
}

// 람다와 연결 /api/user POST
resource "aws_api_gateway_integration" "user_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.root_api.id
  resource_id             = aws_api_gateway_resource.user_resource.id
  http_method             = aws_api_gateway_method.user_post_method.http_method
  integration_http_method = "POST" # Lambda는 POST 메서드를 사용합니다.
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main_handler.invoke_arn
}

// apigateway의 람다 접근권한 설정
resource "aws_lambda_permission" "allow_api_gateway_main_handler" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main_handler.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.root_api.execution_arn}/*/*"
}

// api 배포
resource "aws_api_gateway_deployment" "deploy" {
  rest_api_id = aws_api_gateway_rest_api.root_api.id

  depends_on = [
    aws_api_gateway_integration.user_get_integration,
    aws_api_gateway_integration.user_post_integration,
  ]
}

resource "aws_api_gateway_stage" "dev" {
  deployment_id = aws_api_gateway_deployment.deploy.id
  rest_api_id   = aws_api_gateway_rest_api.root_api.id
  stage_name    = "dev"
}