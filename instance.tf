resource "aws_instance" "jenkins_instance" {
   ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
   instance_type = "t2.micro"
}