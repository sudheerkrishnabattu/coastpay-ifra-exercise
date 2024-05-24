#Create ECS cluster with Fargate

locals {
  cluster_name = "coastpay-ecs"
}


module "ecs" {
  source       = "../modules/aws-ecs"
  cluster_name = local.cluster_name
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        base   = 20
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }
}
