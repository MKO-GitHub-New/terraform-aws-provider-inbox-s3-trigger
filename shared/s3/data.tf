data "aws_caller_identity" "current" {
}

data terraform_remote_state "lambda" {
  backend = "remote"

  config = {
    organization = "mariia-komisar"
    workspaces = {
        name = "mko-lambda-terraform"    }
  }
}