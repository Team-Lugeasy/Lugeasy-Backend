# lambda 소스코드를 저장하는 s3
resource "aws_s3_bucket" "main_lambda_source_bucket" {
  bucket = "main-lambda-source-bucket-root"

  tags = {
    Name        = "main-lambda-source-bucket-root"
    Environment = "dev"
  }
}