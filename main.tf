# Add security group for ssh
resource "aws_security_group" "ssh" {
  name = "ssh"
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Add security group for http
resource "aws_security_group" "http" {
  name = "http"
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Add security group for https
resource "aws_security_group" "https" {
  name = "https"
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Add security group for leet
resource "aws_security_group" "leet" {
  name = "leet"
  ingress {
    description = "leet"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Add key for ssh connection
resource "aws_key_pair" "test" {
  key_name   = "test"
  public_key = "JnQJUcQVIX15lbSuNmKp4H20EMZoanZ3beZEf+eGOnE="
}

module "developer" {
  source = "./developer"
}