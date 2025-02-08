provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  required_version = ">= 1.10.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "sctp-ce8-tfstate"
    key    = "jsstrn-shortener-terraform.tfstate"
    region = "ap-southeast-1"
  }
}