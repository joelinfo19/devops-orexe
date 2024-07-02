provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-05803413c51f242b7"
  instance_type = "t2.micro"

  tags = {
    Name = "first_instance_ec2j"
  }
}

