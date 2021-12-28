resource "aws_instance" "Jenkins" {
   ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
   instance_type = "t2.micro"
}