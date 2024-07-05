provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "prod-eks-labs-terraform-state"

  tags = {
    Name        = "prod-eks-labs-terraform-state"
    Environment = "Prod"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}
