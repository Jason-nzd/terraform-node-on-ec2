variable "aws_region" {
  description = "Region to place all AWS resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_name" {
  description = "Name of EC2 instance"
  type        = string
}

variable "ami" {
  description = "Amazon Machine image to use for EC2 instance"
  type        = string
  default     = "ami-018c0195987eb63ee" // Amazon Linux 2023
}

variable "instance_type" {
  description = "EC2 instance type/size"
  type        = string
  default     = "t2.micro"
}

variable "ssh_key_name" {
  description = "Name of ssh key pair to assign to EC2 instance"
  type        = string
  default     = ""
}

variable "ssh_key_local_path" {
  description = "Path to local ssh key"
  type        = string
  default     = ""
}

variable "security_group_name" {
  description = "Name of VPC Security Group to assign to EC2 instance"
  type        = string
  default     = "SG-WebServer"
}

variable "git_project_url" {
  description = "Git URL for the Node.JS project to git clone"
  type        = string
}
