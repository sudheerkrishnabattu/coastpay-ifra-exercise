#Create ECR Repo

locals {
  region = "us-east-1"
  name   = "ecr-coastpay-${replace(basename(path.cwd), "_", "-")}"

  account_id = data.aws_caller_identity.current.account_id

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "coastpay-ecr"
  }
}


data "aws_caller_identity" "current" {}

module "ecr_disabled" {
  source = "../modules/aws-ecr"
  create = false
}

module "ecr" {
  source                  = "../modules/aws-ecr"
  repository_force_delete = true
  repository_name         = local.name
  create_lifecycle_policy = true
  repository_lifecycle_policy = jsonencode({
    rules = [{
      action       = { type = "expire" }
      description  = "keep last 3 images"
      rulePriority = 1
      selection = {
        countNumber = 3
        countType   = "imageCountMoreThan"
        tagStatus   = "any"
      }
    }]
  })
  tags = local.tags
}
