resource "aws_key_pair" "mykey" {
  key_name   = var.PATH_TO_KEYS["private"]
  public_key = file(var.PATH_TO_KEYS["public"])
}

resource "aws_instance" "aws-instance-1" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  provisioner "file" {
    source      = "./tmp/script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_KEYS["private"])
  }
}
