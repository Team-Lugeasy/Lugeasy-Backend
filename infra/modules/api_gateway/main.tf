// root api
resource "aws_api_gateway_rest_api" "root" {
  name        = "RootAPI"
  description = "API Gateway for root"
}

// apigateway의 람다 접근권한 설정
resource "aws_lambda_permission" "api_gateway_main_handler" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.main_handler_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.root.execution_arn}/*/*"
}

// api 배포
resource "aws_api_gateway_deployment" "root" {
  rest_api_id = aws_api_gateway_rest_api.root.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.root_resource.id,
      aws_api_gateway_method.get_root_method.id,
      aws_api_gateway_integration.get_root_integration.id,

      aws_api_gateway_resource.login_resource.id,
      aws_api_gateway_method.login_method.id,

      aws_api_gateway_resource.test_resource.id,
      aws_api_gateway_method.get_test_method.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "dev" {
  deployment_id = aws_api_gateway_deployment.root.id
  rest_api_id   = aws_api_gateway_rest_api.root.id
  stage_name    = "dev"
}