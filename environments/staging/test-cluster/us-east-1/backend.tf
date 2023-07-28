terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "flutterwave"

    workspaces {
      name = "staging-cluster"
    }
  }
}
