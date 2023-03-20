data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "sg-web-server" {
  name        = "SG-WebServer"
  description = "Allows SSH 22 to specific IP, HTTP 80 & HTTPS 443 to all"
  tags = {
    Name = "SG-WebServer"
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
