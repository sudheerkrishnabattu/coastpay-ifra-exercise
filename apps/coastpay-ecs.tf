#Create ECS cluster with Fargate

data "aws_ecr_image" "api_image" {
  repository_name = "ecr-coastpay-${replace(basename(path.cwd), "_", "-")}"
  most_recent     = true
}

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

resource "aws_ecs_task_definition" "task_definition" {
  family = "coastpay"
  container_definitions = jsonencode(
    [
      {
        "name" : "coastpay-rest-container",
        "image" : join(":", [module.ecr.repository_url, data.aws_ecr_image.api_image.image_tags[0]])
        "entryPoint" : []
        "essential" : true,
        "networkMode" : "awsvpc",
        "portMappings" : [
          {
            "containerPort" : var.container_port,
            "hostPort" : var.container_port,
          }
        ]
      }
    ]
  )
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskRole.arn
}

resource "aws_ecs_service" "ecs_service" {
  name                = "coastpay-ecs-restapi-service"
  cluster             = module.ecs.cluster_id
  task_definition     = aws_ecs_task_definition.task_definition.arn
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  desired_count       = 2 # the number of tasks you wish to run

  network_configuration {
    subnets          = var.private_subnets
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id, aws_security_group.coastpay_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "coastpay-rest-container"
    container_port   = var.container_port
  }
  depends_on = [aws_lb_listener.listener]
}
