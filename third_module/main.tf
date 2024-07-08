provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "dev-eks-labs-terraform-state"
    key    = "public-repository/terraform.tfstate"
    region = "us-east-2"
  }
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.0.1"

  bucket = "my-j-module-public-bucket"
}

variable "region" {
  description = "The region to deploy the resources"
  type        = string
  default     = "us-east-2"
}
