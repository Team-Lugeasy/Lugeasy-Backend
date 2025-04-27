// AWS 프로바이더 설정
provider "aws" {
  region = "ap-northeast-1"
}

// Backend 설정
terraform {
  backend "s3" {
    bucket         = "lugeasy-terraform-state-s3"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    use_lockfile = true
  }
}