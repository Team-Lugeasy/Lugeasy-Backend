# // root api
# resource "aws_api_gateway_rest_api" "root" {
#   name        = "RootAPI"
#   description = "API Gateway for root"
# }

# // [GET] /api
# resource "aws_api_gateway_resource" "root_resource" {
#   rest_api_id = aws_api_gateway_rest_api.root.id
#   parent_id   = aws_api_gateway_rest_api.root.root_resource_id
#   path_part   = "api"
# }

# resource "aws_api_gateway_method" "get_root_method" {
#   rest_api_id   = aws_api_gateway_rest_api.root.id
#   resource_id   = aws_api_gateway_resource.root_resource.id
#   http_method   = "GET"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "get_root_integration" {
#   rest_api_id             = aws_api_gateway_rest_api.root.id
#   resource_id             = aws_api_gateway_resource.root_resource.id
#   http_method             = aws_api_gateway_method.get_root_method.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.main_handler.invoke_arn
# }

# // [POST] /api/login/google
# resource "aws_api_gateway_resource" "login_resource" {
#   rest_api_id = aws_api_gateway_rest_api.root.id
#   parent_id   = aws_api_gateway_resource.root_resource.id
#   path_part   = "login"
# }

# resource "aws_api_gateway_method" "login_method" {
#   rest_api_id   = aws_api_gateway_rest_api.root.id
#   resource_id   = aws_api_gateway_resource.login_resource.id
#   http_method   = "POST"
#   authorization = "NONE"
#   request_parameters = { "method.request.querystring.social" = true }
# }

# resource "aws_api_gateway_integration" "login_integration" {
#   rest_api_id             = aws_api_gateway_rest_api.root.id
#   resource_id             = aws_api_gateway_resource.login_resource.id
#   http_method             = aws_api_gateway_method.login_method.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.main_handler.invoke_arn
# }

# // apigateway의 람다 접근권한 설정
# resource "aws_lambda_permission" "api_gateway_main_handler" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.main_handler.function_name
#   principal     = "apigateway.amazonaws.com"

#   source_arn = "${aws_api_gateway_rest_api.root.execution_arn}/*/*"
# }

# // api 배포
# resource "aws_api_gateway_deployment" "root" {
#   rest_api_id = aws_api_gateway_rest_api.root.id

#   triggers = {
#     redeployment = sha1(jsonencode([
#       aws_api_gateway_resource.root_resource.id,
#       aws_api_gateway_method.get_root_method.id,
#       aws_api_gateway_integration.get_root_integration.id,
#       aws_api_gateway_resource.login_resource.id,
#       aws_api_gateway_method.login_method.id,
#       aws_api_gateway_integration.login_integration.id, 
#     ]))
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_api_gateway_stage" "dev" {
#   deployment_id = aws_api_gateway_deployment.root.id
#   rest_api_id   = aws_api_gateway_rest_api.root.id
#   stage_name    = "dev"
# }