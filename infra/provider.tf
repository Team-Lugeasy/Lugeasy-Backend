// AWS 프로바이더 설정
provider "aws" {
  region = "ap-northeast-3"
}

// Backend 설정
terraform {
  backend "s3" {
    bucket         = "jimjim-terraform-state-bucket-root"
    key            = "terraform.tfstate"
    region         = "ap-northeast-3"
    encrypt        = true
    use_lockfile = true
  }
}


# resource "aws_s3_bucket" "jimjim-terraform-state-bucket-root" {
#   bucket = "jimjim-terraform-state-bucket"
#   versioning {
#     enabled = true
#   }
#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }
# }