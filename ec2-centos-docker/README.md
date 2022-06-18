# CentOS EC2 Instance with Docker using Terraform

Deploy a CentOS EC2 Instance with Docker in AWS using Terraform

**⚠️ Before you can deploy a EC2 CentOS Instance in AWS using Terraform, you need to follow steps below.**

- Update the CentOS version
  - change the `ami` line in the `linux-vm-main.tf` file, with a variable from the `centos-versions.tf` file.
- In the `terraform.tfvars` file, update the following variables:
  - `app_name`: The name of the app, used to create the `app_name` tag for the EC2 instance.
  - `app_environment`: The environment of the app, like Dev, Test, Staging, Prod, etc for the EC2 instance (optional).
  - `aws_access_key`: The AWS access key.
  - `aws_secret_key`: The AWS secret key.
  - `aws_region` variable with the AWS region you want to deploy to.
