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