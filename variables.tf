variable "region" {
  default = "us-east-2"
}

variable "ami_id" {
  type = "map"

  default = {
    us-east-2    = "ami-05803413c51f242b7"
  }
}
