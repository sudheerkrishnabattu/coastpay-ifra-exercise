#create security groups for alb and alb with listeners and attach target groups
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

resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.alb_boolean
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.coastpay_sg.id]
  subnets            = var.public_subnets
  tags = {
    Environment = "Dev"
    Department  = "Coastpay"
  }
  depends_on = [
    aws_security_group.coastpay_sg
  ]
}
