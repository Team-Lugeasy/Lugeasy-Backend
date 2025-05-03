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


resource "aws_iam_policy" "main_lambda_ecr_access_policy" {
  name        = "main_lambda_ecr_access_policy"
  description = "IAM policy for Lambda to access ECR repository"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetRepositoryPolicy",
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage"
        ],
        Resource = "arn:aws:ecr:ap-northeast-1:448522292146:repository/lugeasy-main-ecr-repo"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "main_lambda_ecr_access_attachment" {
  role       = aws_iam_role.main_lambda.name
  policy_arn = aws_iam_policy.main_lambda_ecr_access_policy.arn
}