terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "HashiCorp-Sam"

    workspaces {
      name = "terraformer-gcp"
    }
  }
}

provider "google" {
  project = "sam-gabrail-gcp-demos"
  version = "~>v3.30.0"
}

