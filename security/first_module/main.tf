module "test_env_module" {
  source = "github.com/akilblanchard/terraform-aws-ssh-ec2-module.git"

  aws_region        = "us-east-2"
  file_name         = "tf_key"
  ec2_instance_name = "test"
  key_pair_name     = "tfkey"
  cidr_block        = "10.0.0.0/16"
  counter           = 2
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  instance_tag      = ["main_server", "test_server", "test_server"]
  s3_bucket_name    = "ab-tf-statelck"
  s3_versioning     = "Enabled"
  force_destroy = true
  db_table_name     = "tf-state-db"

}



#terraform {
# backend "s3" {
#  bucket                  = "ab-tf-statelck"
#  key                     = "s3-backend/terraform.tfstate"
#  region                  = "us-east-1"
#  dynamodb_table          = "tf-state-db"
#  encrypt                 = true
#  shared_credentials_file = "~/.aws/credentials"
#  profile                 = "default"
# }
#}

#Outputs

output "kms_key" {
  value       = module.test_env_module.kms_key
}

output "instance_public_ip" {
  value       = module.test_env_module.instance_public_ip[*]
}

output "instance_private_ip" {
  value = module.test_env_module.instance_private_ip[*]

}