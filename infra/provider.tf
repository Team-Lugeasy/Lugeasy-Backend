// AWS 프로바이더 설정
provider "aws" {
  region = "ap-northeast-3"
}

// Backend 설정
terraform {
  backend "s3" {
    bucket         = "jimjim-terraform-state-bucket-test"
    key            = "terraform.tfstate"
    region         = "ap-northeast-3"
    encrypt        = true
    use_lockfile = true
  }
}


# resource "aws_s3_bucket" "jimjim_terraform_state_bucket" {
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