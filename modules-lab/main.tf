provider "aws" {
  profile = "terraform"
}

terraform {
  backend "s3" {
    bucket         = "vedas-lab-bucket-001"
    key            = "state/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}


module "s3_bucket" {
  source = "./modules/S3"
  bucket_name = "vedas-lab-bucket-001"
}

resource "aws_s3_bucket" "imported" {
  bucket = "project-vedashree-data-lake"
}


output "my_bucket_id" {
  value = module.s3_bucket.bucket_id
}

output "my_bucket_arn" {
  value = module.s3_bucket.bucket_arn
}

output "my_bucket_domain" {
  value = module.s3_bucket.bucket_domain
}