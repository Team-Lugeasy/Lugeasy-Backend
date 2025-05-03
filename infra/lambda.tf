resource "aws_lambda_function" "main_handler" {
  function_name     = "main_handler"
  role              = aws_iam_role.main_lambda.arn

  image_uri    = "${aws_ecr_repository.lugeasy_main_ecr_repo.repository_url}:latest"
  package_type = "Image"

  lifecycle {
    create_before_destroy = true
  }
}
