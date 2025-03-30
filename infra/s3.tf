# lambda 소스코드를 저장하는 s3
resource "aws_s3_bucket" "lugeasy_lambda_source_bucket" {
  bucket = "lugeasy-lambda-source-bucket"

  tags = {
    Name        = "lugeasy-lambda-source-bucket"
    Environment = "dev"
  }
}