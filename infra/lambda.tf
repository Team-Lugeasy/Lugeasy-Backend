data "archive_file" "main_handler_zip" {
  type        = "zip"
  source_file = "${path.module}/../src/main_handler.py"
  output_path = "src/main_handler.zip"
}

resource "aws_lambda_function" "main_handler" {
  filename      = "src/main_handler.zip"
  function_name = "main_handler"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "main_handler.main_handler"
  runtime       = "python3.9" 
  timeout       = 10
}
