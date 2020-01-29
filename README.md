# Terraform Laravel Pipeline

[![CircleCI](https://github.com/prajavat/terraform-laravel-pipeline/blob/master/docs/passed.svg)]()

A Terraform module to create an AWS CodePipeline 

## Install AWSClI

1. Download & install for [Windows](https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi)
1. Download & install for [Ubunu](https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html)

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan -out terraform.plan
terraform apply terraform.plan
```

## Variables

- `stage` - Name of the Environment of application `stage` `prod` `testing` (default: `dev`)
- `app_name` - Name of application (default: `example-webapp`)
- `instance_type` - EC2 Instance type for your applicaton (default: `t2.micro`)
- `key_name` - EC2 Instance PEM Key name, `Make sure Enter conrrect pem key as aws region` (`Required: []`)
- `desired_capacity` - Desired number of EC2 instances in AutoScaling Group (default: `1`)
- `min_size` - Minimum number of EC2 instances in AutoScaling Group (default: `1`)
- `max_size` - Maximum number of EC2 instances in AutoScaling Group (default: `1`)

**Note**: If you're using github account for SCM in aws-pipeline then update below Properties.

- `github_auth_token` - Github account authication token (`Required: []`)
- `github_user` - Github account username (`Required: []`)
- `github_repo` - Github account repository, which is you're going to use in pipeline. (`Required: []`)
- `github_branch` - Github repository branch name (default: `master`)

## Outputs

- `ec2_instance_name` - The EC2 Instance Name
