resource "aws_dynamodb_table" "users" {
  name           = "Users"
  billing_mode   = "PAY_PER_REQUEST" 
  hash_key       = "id"
  range_key      = "name" 

  attribute {
    name = "id"
    type = "S" 
  }

  attribute {
    name = "name" 
    type = "S" 
  }


  tags = {
    Name        = "UsersTable"
    Environment = "production" 
  }
}