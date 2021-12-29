resource "aws_instance" "jenkins_instance" {
   ami           = local.us_east_2_ami
   instance_type = local.instance_type
}