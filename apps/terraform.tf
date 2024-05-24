terraform {
  backend "remote" {
    organization = "flux-node"

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

