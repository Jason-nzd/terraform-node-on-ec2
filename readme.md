# Terraform Node Server on EC2 Amazon Linux

This Terraform script creates an EC2 Server running Amazon Linux. The provided userdata script installs nvm, node, and iptables. It then git clones a node project off github, installs node packages, and runs the node server with mapped ports.

A security group is also created on the default VPC with open ports for HTTP and HTTPS. In addition SSH is whitelisted to the specific IP address that is running this script.

## Setup

Requires terraform to be installed and global AWS credentials to be set.

The node project must have definitions for `npm run start` in `package.json`.

Initialize and validate with:

```terraform
terraform init
terraform validate
```

Apply the infrastructure with:

```terraform
terraform apply
```

Destroy with:

```terraform
terraform destroy
```

## Outputs

Various `terraform output` outputs are available for quick access:

```bash
instance_public_dns = "http://ec2-13-211-204-194.ap-southeast-2.compute.amazonaws.com"
instance_public_ip  = "13.211.204.194"
scp_cloud_init_copy = "scp -i keypair.pem ec2-user@13.211.204.194:/var/log/cloud-init-output.log ec2.log"
ssh_command         = "ssh -i keypair.pem ec2-user@13.211.204.194"
```
