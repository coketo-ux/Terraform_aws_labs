terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
  access_key = "AKIA565WRLTDXMULVDV3"
  secret_key = "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"
}