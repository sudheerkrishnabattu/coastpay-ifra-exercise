resource "aws_security_group" "ecs_sg" {
  vpc_id                 = var.vpc_id
  name                   = "coastpay-sg-ecs"
  description            = "Security group for ecs app"
  revoke_rules_on_delete = true

  ingress {
    description              = "Allow inbound traffic from ALB"
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    security_groups        = ["${aws_security_group.coastpay_sg.id}"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    description       = "Allow outbound traffic from ECS"
  }
}


resource "aws_security_group" "coastpay_sg" {
  name        = "coastpay-sg"
  description = "Allow HTTPS to rest endpoint"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

