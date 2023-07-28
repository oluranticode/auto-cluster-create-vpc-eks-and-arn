terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "flutterwave"

    workspaces {
      name = "Auto-cluster-setup"
    }
  }
}




# terraform {
#   backend "s3" {
#     key                     = "terraform/tfstate.tfstate"
#     bucket                  = "unavailable-rmt-backend"
#     region                  = "eu-central-1"
#     profile                 = "default"
#     shared_credentials_file = "~/.aws/credentials"
#   }
# }