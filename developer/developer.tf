terraform {
  required_providers {
    ansible = {
      source = "ansible/ansible"
    }
  }
}

variable "key_name" {}
variable "ssh_security_group" {}
variable "http_security_group" {}
variable "https_security_group" {}

output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.redmine.public_ip
}

# Create ec2 instance
resource "aws_instance" "redmine" {
  ami = "ami-0aafdae616ee7c9b7"
  instance_type = "t2.micro"
  tags = {
    Name = "redmine"
    Service = "ticketingSoftware"
  }
  key_name = var.key_name
  root_block_device {
    volume_size = 15
  }
  security_groups = [var.ssh_security_group, var.http_security_group, var.https_security_group, "default"]
}

# Add created ec2 instance to ansible inventory
resource "ansible_host" "redmine" {
  name = aws_instance.redmine.public_dns
  groups = ["redmine"]
  variables = {
    ansible_user                 = "admin",
    ansible_ssh_private_key_file = "../test.pem",
    ansible_python_interpreter   = "/usr/bin/python3",
  }
}

resource "ansible_playbook" "redmine" {
  playbook = "redmine.yml"
  name = "redmine"
}