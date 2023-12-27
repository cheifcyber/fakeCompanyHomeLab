# Create ec2 instance
resource "aws_instance" "Redmine" {
  ami           = "ami-058bd2d568351da34"
  instance_type = "t2.micro"
  tags = {
    Service = "ticketingSoftware"
    Software = "redmine"
  }
  key_name        = aws_key_pair.test.key_name
  root_block_device {
    volume_size = 15
  }
  security_groups = [aws_security_group.ssh.name, aws_security_group.http.name, aws_security_group.https.name, aws_security_group.leet.name, "default"]
}

# Add created ec2 instance to ansible inventory
resource "ansible_host" "Redmine" {
  name   = aws_instance.Redmine.public_dns
  groups = ["redmine"]
  variables = {
    ansible_user                 = "admin",
    ansible_ssh_private_key_file = "../test.pem",
    ansible_python_interpreter   = "/usr/bin/python3",
  }
}