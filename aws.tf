# terraform {

#   backend "s3" {
#     bucket               = "prajavat-terraform-state-backet"
#     encrypt              = "true"
#     region               = "us-east-1"
#     key                  = "terraform.tfstate"
#     workspace_key_prefix = "tgw"
#   }
# }

provider "aws" {
  region = var.region
}
