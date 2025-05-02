# terraform lock state를 저장하는 s3
resource "aws_s3_bucket" "lugeasy_terraform_state_s3" {
  bucket = "lugeasy-terraform-state-s3"

  tags = {
    Name        = "lugeasy-terraform-state-s3"
    Environment = "dev"
  }
}

# lambda 소스코드를 저장하는 s3
resource "aws_s3_bucket" "lugeasy_main_lambda_source_s3" {
  bucket = "lugeasy-main-lambda-source-s3"

  tags = {
    Name        = "lugeasy-main-lambda-source-s3"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "lugeasy_main_lambda_source_s3_versioning" {
  bucket = aws_s3_bucket.lugeasy_main_lambda_source_s3.id
  versioning_configuration {
    status = "Disabled"
  }
}