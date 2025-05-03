# data "archive_file" "main_lambda_archive_file" {
#   type        = "zip"
#   source_dir  = "${path.module}/../src"
#   output_path = "${path.module}/lugeasy_lambda_source_file.zip"

#   # source_dir이 변경되었음을 Terraform에게 확실히 알려줌
#   depends_on = [null_resource.force_zip_regen]
# }

# resource "null_resource" "force_zip_regen" {
#   triggers = {
#     force_update = timestamp()
#   }
# }

# resource "aws_s3_object" "main_lambda_source_file" {
#   bucket = aws_s3_bucket.lugeasy_main_lambda_source_s3.id
#   key = "lugeasy_lambda_source_file.zip"
#   source = data.archive_file.main_lambda_archive_file.output_path
# }

resource "aws_lambda_function" "main_handler" {
  function_name     = "main_handler"
  # handler           = "main_handler.main_handler"
  role              = aws_iam_role.main_lambda.arn

  image_uri    = "${aws_ecr_repository.lugeasy_main_ecr_repo.repository_url}:latest"
  package_type = "Image"
  
  memory_size = 128
  timeout = 30

  lifecycle {
    create_before_destroy = true
  }
  # s3_bucket         = aws_s3_object.main_lambda_source_file.bucket
  # s3_key            = aws_s3_object.main_lambda_source_file.key
  # s3_object_version = aws_s3_object.main_lambda_source_file.version_id
  # source_code_hash  = data.archive_file.main_lambda_archive_file.output_base64sha256
  # layers = [
  # aws_lambda_layer_version.google_auth_layer.arn
  # ]
  # depends_on        = [aws_s3_object.main_lambda_source_file]

  # runtime           = "python3.10"
  # timeout           = 10
  # publish           = true
}
