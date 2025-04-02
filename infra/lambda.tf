resource "aws_s3_object" "main_lambda_source_file" {
  bucket = aws_s3_bucket.main_lambda_source_bucket.id
  key = "main_lambda_source_file.zip"
  source = data.archive_file.main_lambda_archive_file.output_path
  etag   = filemd5("${path.module}/main_lambda_source_file.zip")
}

resource "aws_lambda_function" "main_handler" {
  function_name = "main_handler"
  handler       = "main_handler.main_handler"

  role          = aws_iam_role.main_lambda.arn

  s3_bucket = aws_s3_object.main_lambda_source_file.bucket
  s3_key = aws_s3_object.main_lambda_source_file.key
  source_code_hash  = filebase64sha256("${path.module}/main_lambda_source_file.zip")

  runtime       = "python3.10" 
  timeout       = 10
}
