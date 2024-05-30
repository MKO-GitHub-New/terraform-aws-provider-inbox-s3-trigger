terraform {
  cloud {
    organization = "mariia-komisar"

    workspaces {
      name = "mko-s3-terraform"
    }
  }
}

