data "archive_file" "main_lambda_archive_file" {
  type        = "zip"
  source_dir = "../src"
  output_path = "main_lambda_source_file.zip"
}

resource "aws_s3_object" "main_lambda_source_file" {
  bucket = aws_s3_bucket.lugeasy_lambda_source_bucket.id
  key = "main_lambda_source_file.zip"
  source = data.archive_file.main_lambda_archive_file.output_path
}

resource "aws_lambda_function" "main_handler" {
  function_name = "main_handler"
  handler       = "main_handler.main_handler"

  role          = aws_iam_role.main_lambda.arn

  s3_bucket = aws_s3_object.main_lambda_source_file.bucket
  s3_key = aws_s3_object.main_lambda_source_file.key
  source_code_hash = data.archive_file.main_lambda_archive_file.output_base64sha256

  runtime       = "python3.10" 
  timeout       = 10
}
