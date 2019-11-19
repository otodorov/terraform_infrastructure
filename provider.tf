# Working with Terraform v0.12.8
provider "aws" {
  version                 = "~> 2.28"
  shared_credentials_file = var.aws_credentials_file
  profile                 = var.aws_profile
  region                  = var.aws_region
}
