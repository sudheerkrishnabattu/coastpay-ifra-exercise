vpc_id          = "vpc-09f8a0427955f082a"
alb_name        = "coastpay-alb-dev"
alb_boolean     = "false"
alb_type        = "application"
logs_s3_name    = "coastpay-s3"
public_subnets  = ["subnet-01eb273b2bacd9f16", "subnet-0b580482426f4f25d", "subnet-0cac739af9eba6a22"]
private_subnets = ["subnet-0fb843b22f4432676", "subnet-0aa579f622a3c7d98", "subnet-0dbbc320532e1ca78"]
container_port  = 80
