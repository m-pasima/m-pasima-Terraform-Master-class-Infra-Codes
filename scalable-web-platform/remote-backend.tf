# setup s3 Bucket for Terraform state

terraform {
  backend "s3" {
    bucket  = "demo-basics"
    key     = "scalable-web-platform/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true

  }
}
