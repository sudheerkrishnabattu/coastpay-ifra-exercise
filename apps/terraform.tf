terraform {
  backend "remote" {
    organization = "fluxnode"

    workspaces {
      name = "coastpay-ifra-exercise"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.37"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

