resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name = "lambda_dynamodb_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "dynamodb:PutItem",
        "dynamodb:GetItem"
      ],
      Effect = "Allow",
      Resource = aws_dynamodb_table.users.arn
    }]
  })
}
