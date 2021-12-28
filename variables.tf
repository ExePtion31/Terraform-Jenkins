variable "AWS_REGION"{
    default = "us-east-2"
}

variable "AMIS" {
  type = map(string)
  default = {
    "us-east-2" = "ami-05803413c51f242b7"
  }
}

variable "PATH_TO_LAMBDA" {
  type = map(string)
  default = {
    unzip = "./files/index.js"
    zip = "./files/index.zip"
  }
}

variable "INSTANCE_USERNAME" {
  type = string
  default = "ubuntu"
}

variable "stack_id" {
  type = string
  default = "terraform-course"
}
