provider "aws" {
  region  = "eu-west-2"
  profile = "terraform"
}

module "dynamodb" {
  source        = "./modules/dynamodb"
  table_name    = "vedashree-lab-table"
  hash_key      = "id"
  hash_key_type = "S"

  tags = {
    Environment = "dev"
    Owner       = "Vedashree"
  }
}
