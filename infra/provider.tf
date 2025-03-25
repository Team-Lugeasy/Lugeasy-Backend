resource "aws_s3_bucket" "jimjim_terraform_state_bucket" {
  bucket = "jimjim-terraform-state-bucket" # 고유한 버킷 이름 지정
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "jimjim_terraform_state" {
  name           = "jimjim-terraform-state"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}