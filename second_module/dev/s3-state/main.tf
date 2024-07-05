provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "dev-eks-labs-terraform-state"

  tags = {
    Name        = "dev-eks-labs-terraform-state"
    Environment = "Dev"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}
