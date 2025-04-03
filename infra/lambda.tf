data "archive_file" "main_lambda_archive_file" {
  type        = "zip"
  source_dir  = "${path.module}/../src"
  output_path = "${path.module}/main_lambda_source_file.zip"

  # source_dir이 변경되었음을 Terraform에게 확실히 알려줌
  depends_on = [null_resource.force_zip_regen]
}

resource "null_resource" "force_zip_regen" {
  triggers = {
    force_update = timestamp()
  }
}

resource "aws_s3_object" "main_lambda_source_file" {
  bucket = aws_s3_bucket.main_lambda_source_bucket.id
  key    = "main_lambda_source_file_${data.archive_file.main_lambda_archive_file.output_base64sha256}.zip"
  source = data.archive_file.main_lambda_archive_file.output_path
  depends_on = [data.archive_file.main_lambda_archive_file]
}

resource "aws_lambda_function" "main_handler" {
  function_name     = "main_handler"
  handler           = "main_handler.main_handler"
  role              = aws_iam_role.main_lambda.arn

  s3_bucket         = aws_s3_object.main_lambda_source_file.bucket
  s3_key            = aws_s3_object.main_lambda_source_file.key
  s3_object_version = aws_s3_object.main_lambda_source_file.version_id
  source_code_hash  = data.archive_file.main_lambda_archive_file.output_base64sha256

  runtime           = "python3.10"
  timeout           = 10
  publish           = true

  depends_on        = [aws_s3_object.main_lambda_source_file]
}
