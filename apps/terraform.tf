terraform {
  backend "remote" {
    organization = "flux-node"

    workspaces {
      name = "coastpay-ifra-exercise"
    }
  }
}

