terraform {
  required_providers {
    aws = {
      source = "opentofu/aws"
      version = "~> 5.94"
    }
  }
}

provider "aws" {
    region = var.aws_region
}
