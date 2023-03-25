# Terraform - Node Server on EC2 Amazon Linux

This Terraform code creates an EC2 Server running Amazon Linux. The user data `install_node_git.sh` script installs nvm, node, git, and iptables. It then git clones a specified node project, installs node packages, and runs the node server with mapped ports.

A security group is also created on the default VPC with open ports for HTTP and HTTPS. SSH is whitelisted to the auto-detected IP address that is running this script.

## Setup

Requires terraform to be installed and global AWS credentials to be set.

The most important variables can get set in `terraform.tfvars`, such as:

```terraform
instance_name   = "Next.js Web Server"
ssh_key_name    = "MyAWSKeyPair"
git_project_url = "https://github.com/user/node-project"
```

The `git_project_url` should point to a node project with a valid `package.json` and a valid command for `npm run start`.

Initialize and validate with:

```terraform
terraform init
terraform validate
```

Create and destroy the infrastructure with 

```terraform
terraform apply
terraform destroy
```

## Outputs

Various `terraform output` outputs are available for quick access:

```bash
instance_public_dns = "http://ec2-13-211-204-194.ap-southeast-2.compute.amazonaws.com"
instance_public_ip  = "13.211.204.194"
scp_cloud_init_log  = "scp -i keypair.pem ec2-user@13.211.204.194:/var/log/cloud-init-output.log cloud-init-output.log"
ssh_command         = "ssh -i keypair.pem ec2-user@13.211.204.194"
```
