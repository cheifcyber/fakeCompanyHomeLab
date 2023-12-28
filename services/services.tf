terraform {
  required_providers {
    ansible = {
      source = "ansible/ansible"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

variable "key_name" {}
variable "ssh_security_group" {}
variable "http_security_group" {}
variable "https_security_group" {}
variable "leet_security_group" {}
variable "testHttp_security_group" {}

# Create ec2 instance
resource "aws_instance" "nextcloud" {
  ami = "ami-0aafdae616ee7c9b7"
  instance_type = "t2.micro"
  tags = {
    Name = "nextcloud"
    Service = "IdentiyManagment"
  }
  key_name = var.key_name
  root_block_device {
    volume_size = 10
  }
  security_groups = [var.ssh_security_group, var.http_security_group, var.https_security_group, "default"]
}

# Add created ec2 instance to ansible inventory
resource "ansible_host" "nextcloud" {
  name   = aws_instance.nextcloud.public_ip
  groups = ["nextcloud"]
  variables = {
    ansible_user                 = "admin",
    ansible_ssh_private_key_file = "/opt/keys/fakeCorp.pem",
    ansible_python_interpreter   = "/usr/bin/python3",
  }
}

# Ansible playbook terraform resource sucks so here you go
resource "null_resource" "nextcloudPlaybook" {
  depends_on = [aws_instance.nextcloud, ansible_host.nextcloud]

  provisioner "local-exec" {
    command = "sleep 15 && ansible-playbook -i ./inventory.yml --extra-vars \"@../vars/yml\" ./services/nextcloud.yml"
  }
}