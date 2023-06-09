provider "aws" {
  region = var.aws_region
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_ami" "latest-amazon-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "ec2_server" {
  ami                    = data.aws_ami.latest-amazon-linux.id
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.sg-web-server.id]
  user_data = templatefile("install_node_git.sh", {
    git_project_url    = var.git_project_url
    git_project_folder = element(reverse(split("/", var.git_project_url)), 0)
  })
  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "sg-web-server" {
  name        = var.security_group_name
  description = "Allows SSH 22 to specific IP, HTTP 80 & HTTPS 443 to all"
  tags = {
    Name = var.security_group_name
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
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
