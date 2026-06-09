terraform {
  required_version = ">= 1.0.0"

  # We declare the required cloud providers we need for this project
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # This installs version 5.x of the AWS provider
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region # We use a variable so we don't hardcode the region
}