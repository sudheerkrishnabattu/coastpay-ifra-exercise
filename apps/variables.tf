variable "vpc_id" {
  type        = string
  description = "Declare vpc id"
}

variable "alb_name" {
  type        = string
  description = "Declare ALB name"
}

variable "alb_boolean" {
  type        = bool
  description = "Declare if alb is internal with boolean value which should be set to True or false"
}

variable "alb_type" {
  type        = string
  description = "set alb type such as application"
}

variable "container_port" {
  type        = number
  description = "port number to expose container"
}

variable "public_subnets" {
  type        = list(string)
  description = "Declare public subnets"
}

variable "logs_s3_name" {
  type        = string
  description = "S3 bucket used for logs"
}
