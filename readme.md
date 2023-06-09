# Terraform - Node Server on EC2 Amazon Linux

This Terraform code creates an EC2 Server running Amazon Linux. The bash shell script `install_node_git.sh` installs nvm, node, git, and iptables. The script then git clones a specified node project, installs required node packages, and finally runs the node server with mapped ports.

A security group is also created on the default VPC with open ports for HTTP and HTTPS. SSH Port 22 is whitelisted to the auto-detected IP address that applied this script.

## Setup

Requires terraform to be installed and global AWS credentials to be set.

The most important variables are set in `terraform.tfvars`, such as:

```terraform
instance_name      = "Node.js Web Server"
git_project_url    = "https://github.com/user/node-project"
ssh_key_name       = "mykeypair"
ssh_key_local_path = "C:\\MyPath\\FolderContainingKeyPair\\"
```

The `git_project_url` should point to a node project with a valid `package.json` and a valid command for `npm run start`.

Initialize and validate with:

```terraform
terraform init
terraform validate
```

Create and destroy the infrastructure with:

```terraform
terraform apply
terraform destroy
```

## Outputs

Upon applying this terraform, various `terraform output` outputs will be available for quick access to the web server:

```bash
instance_public_dns = "http://ec2-13-211-204-194.ap-southeast-2.compute.amazonaws.com"
instance_public_ip  = "13.211.204.194"
```

Quick commands are created for ssh access and copying of the cloud-init-output.log. This log can be examined to see the progress of the installation script.

```bash
scp_cloud_init_log  = "scp -i keypair.pem ec2-user@13.211.204.194:/var/log/cloud-init-output.log cloud-init-output.log"
ssh_command         = "ssh -i keypair.pem ec2-user@13.211.204.194"
```
