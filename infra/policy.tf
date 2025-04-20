resource "aws_iam_policy" "main_lambda_dynamodb" {
  name = "main_lambda_dynamodb_policy"

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

# CloudWatch 로그를 위한 IAM 정책
resource "aws_iam_policy" "main_lambda_logging" {
  name = "main_lambda_logging_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# 위 정책을 Lambda IAM Role에 붙이기
resource "aws_iam_role_policy_attachment" "main_lambda_logging_attach" {
  role       = aws_iam_role.main_lambda.name
  policy_arn = aws_iam_policy.main_lambda_logging.arn
}

