terraform {
  required_providers {
    mycloud = {
      source = "hashicorp/aws"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    bucket = "terraform-course-bucket-state"
    key = "terraform.tfstate"
    region = "us-east-2"
    encrypt = true
  }
  required_version = ">= 0.12"
}