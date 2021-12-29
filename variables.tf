variable "AWS_REGION"{
    default = "us-east-2"
}

variable "ami_id" {
  default = {
    "us-east-2" = "ami-05803413c51f242b7"
  }
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "path_lambda" {
  type = map(string)
  default = {
    unzip = "./files/index.js"
    zip = "./files/index.zip"
  }
}

variable "stack_id" {
  type = string
  default = "terraform-course"
}