terraform {
  backend "s3" {
    bucket = "hasan-my-tf-website-state"
    key = "global/s3/terraform.tfstate"
    region = "eu-central-1"   # Europe (Frankfurt)
    dynamodb_table = "my-db-website-table"
  }
}