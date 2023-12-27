terraform {
  required_providers {
    ansible = {
      version = "1.1.0"
      source  = "ansible/ansible"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"  # Set the AWS region
}

provider "ansible" {
}