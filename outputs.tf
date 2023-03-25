output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2_server.public_ip
}

output "instance_http_address" {
  description = "Public http address of the EC2 instance"
  value       = "http://${aws_instance.ec2_server.public_dns}"
}

output "scp_cloud_init_log" {
  description = "SCP command to copy the remote cloud-init-output.log - for monitoring userdata status"
  value       = "scp -i ${var.ssh_key_name}.pem ec2-user@${aws_instance.ec2_server.public_ip}:/var/log/cloud-init-output.log cloud-init-output.log"
}

output "ssh_command" {
  description = "SSH command for connecting to EC2 instance"
  value       = "ssh -i ${var.ssh_key_name}.pem ec2-user@${aws_instance.ec2_server.public_ip}"
}
