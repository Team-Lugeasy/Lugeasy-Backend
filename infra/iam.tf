resource "aws_iam_role" "main_lambda" {
  name = "main_lambda_iam_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "main_lambda_dynamodb" {
  role       = aws_iam_role.main_lambda.name
  policy_arn = aws_iam_policy.main_lambda_dynamodb.arn
}