resource "aws_ecr_repository" "lugeasy_main_ecr_repo" {
  name                 = "lugeasy-main-ecr-repo"
  image_tag_mutability = "MUTABLE"  
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "lugeasy_main_ecr_repo_lilfecycle_policy" {
  repository = aws_ecr_repository.lugeasy_main_ecr_repo.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images after 30 days"
        selection    = {
          tagStatus = "untagged"
          countType = "sinceImagePushed"
          countUnit = "days"
          countNumber = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
 
resource "aws_ecr_repository_policy" "lugeasy_main_ecr_repo_policy" {
  repository = aws_ecr_repository.lugeasy_main_ecr_repo.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "Set the permission for ECR",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}
