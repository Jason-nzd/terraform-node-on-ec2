terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_security_group" "sg-web-server" {
  name        = "SG-WebServer"
  description = "Allows SSH 22, HTTP 80 & HTTPS 443"
  tags = {
    Name = "SG-WebServer"
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "ec2_server" {
  ami                    = "ami-018c0195987eb63ee" // Amazon Linux 2023
  instance_type          = "t2.micro"
  key_name               = "WellAWSKeyPair"
  vpc_security_group_ids = [aws_security_group.sg-web-server.id]
  user_data              = file("userdata.sh")
  tags = {
    Name = "Next.js Web Server"
  }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2_server.public_ip
}
output "instance_public_dns" {
  description = "Public domain address of the EC2 instance"
  value       = aws_instance.ec2_server.public_dns
}
