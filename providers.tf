terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 1.7"
}
