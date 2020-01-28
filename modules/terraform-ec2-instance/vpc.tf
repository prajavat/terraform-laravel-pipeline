module "main-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform   = "true"
    Environment = var.stage
  }
}

output "vpc_id" {
  value       = module.main-vpc.vpc_id
}

output "public_subnets" {
  value       = module.main-vpc.public_subnets
}