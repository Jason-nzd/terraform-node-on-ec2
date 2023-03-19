# Terraform Node Server on EC2 Amazon Linux

This Terraform script creates an EC2 Server running Amazon Linux. It installs nvm, node, and iptables. It then git clones a node project off github, installs node packages, and runs the node server with mapped ports.

A security group is also created on the default VPC with open ports for SSH, HTTP, and HTTPS.

## Setup

Requires terraform to be installed, and global AWS credentials to be set.

The node project must have definitions for `npm run start` in `package.json`.

Initialize and validate with:

```terraform
terraform init
terraform validate
```

Apply the infrastructure and then get resulting IP address to connect to with:

```terraform
terraform apply
terraform output
```

Destroy with:

```terraform
terraform destroy
```
