locals {
  aws_region = "us-east-2"
  common_tags = {
    stack_id   = var.stack_id,
    enviroment = var.enviroment,
    origin     = "terraform"
  }
}