module "api_gateway" {
  source = "./modules/api_gateway"

  main_handler_invoke_arn = aws_lambda_function.main_handler.invoke_arn
  main_handler_function_name = aws_lambda_function.main_handler.function_name
}