terraform {
  backend "s3" {
    bucket         = "pokernowai-terraform-state"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "pokernowai-terraform-lock"
  }
}
