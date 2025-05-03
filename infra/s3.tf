# terraform lock state를 저장하는 s3
resource "aws_s3_bucket" "lugeasy_terraform_state_s3" {
  bucket = "lugeasy-terraform-state-s3"

  tags = {
    Name        = "lugeasy-terraform-state-s3"
    Environment = "dev"
  }
}