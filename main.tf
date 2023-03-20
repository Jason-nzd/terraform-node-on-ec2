terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.59"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.2.1"
    }
  }
  required_version = ">= 1.4.2"
}

provider "aws" {
  region = "ap-southeast-2"
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
output "instance_http_address" {
  description = "Public http address of the EC2 instance"
  value       = "http://${aws_instance.ec2_server.public_dns}"
}
output "scp_cloud_init_log_command" {
  description = "SCP command to copy the remote cloud-init-output.log - for monitoring userdata status"
  value       = "scp -i WellAWSKeyPair.pem ec2-user@${aws_instance.ec2_server.public_ip}:/var/log/cloud-init-output.log ec2.log"
}
output "ssh_command" {
  description = "SSH command for connecting to EC2 instance"
  value       = "ssh -i WellAWSKeyPair.pem ec2-user@${aws_instance.ec2_server.public_ip}"
}
