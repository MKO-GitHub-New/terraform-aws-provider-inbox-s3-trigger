terraform {
  cloud {
    organization = "mariia-komisar"

    workspaces {
      name = "mko-lambda-terraform"
    }
  }
}

