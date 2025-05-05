# main lambda
resource "aws_lambda_function" "main_handler" {
  function_name     = "main_handler"
  role              = aws_iam_role.main_handler_iam_role.arn

  image_uri    = "${aws_ecr_repository.lugeasy_main_ecr_repo.repository_url}:latest"
  package_type = "Image"

  lifecycle {
    create_before_destroy = true
  }
}

# main lambda iam role
resource "aws_iam_role" "main_handler_iam_role" {
  name = "main_handler_iam_role"

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

# main lambda -> dynamodb access policy
resource "aws_iam_policy" "main_handler_dynamodb_policy" {
  name = "main_handler_dynamodb_policy"

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

# main lambda -> cloduwatch access policy
resource "aws_iam_policy" "main_handler_cloudwatch_policy" {
  name = "main_handler_cloudwatch_policy"

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

# main lambda -> ecr access policy
resource "aws_iam_policy" "main_handler_ecr_policy" {
  name        = "main_handler_ecr_policy"

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

# main lambda -> dynamodb access policy attachment
resource "aws_iam_role_policy_attachment" "main_handler_dynamodb_policy_attachment" {
  role       = aws_iam_role.main_handler_iam_role.name
  policy_arn = aws_iam_policy.main_handler_dynamodb_policy.arn
}

# main lambda -> dynamodb access cloudwatch attachment
resource "aws_iam_role_policy_attachment" "main_handler_cloudwatch_policy_attachment" {
  role       = aws_iam_role.main_handler_iam_role.name
  policy_arn = aws_iam_policy.main_handler_cloudwatch_policy.arn
}

# main lambda -> dynamodb access ecr attachment
resource "aws_iam_role_policy_attachment" "main_handler_ecr_policy_attachment" {
  role       = aws_iam_role.main_handler_iam_role.name
  policy_arn = aws_iam_policy.main_handler_ecr_policy.arn

}
