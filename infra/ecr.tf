resource "aws_ecr_repository" "lugeasy_main_ecr_repo" {
  name                 = "lugeasy-main-ecr-repo"
  image_tag_mutability = "MUTABLE"  
  force_delete = false
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

# resource "null_resource" "push_initial_dummy_image" {
#   depends_on = [
#     aws_ecr_repository.lugeasy_main_ecr_repo,
#     aws_ecr_repository_policy.lugeasy_main_ecr_repo_policy,
#     aws_ecr_lifecycle_policy.lugeasy_main_ecr_repo_lilfecycle_policy
#   ]

#   provisioner "local-exec" {
#     command = <<EOT
#       ACCOUNT_ID=AKIAWQ3QDBOZF5TZNLXZ
#       REGION=ap-northeast-1
#       ECR_REPO_NAME=${aws_ecr_repository.lugeasy_main_ecr_repo.name}
#       ECR_REGISTRY=${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com
#       aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${ECR_REGISTRY}

#       docker pull alpine/git:latest
#       docker tag alpine/git:latest ${ECR_REGISTRY}/${ECR_REPO_NAME}:initial

#       docker push ${ECR_REGISTRY}/${ECR_REPO_NAME}:initial
#     EOT
#   }
# }