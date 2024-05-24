#create alb with listeners and attach target groups

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

resource "aws_lb_target_group" "target_group" {
  name        = "test-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
