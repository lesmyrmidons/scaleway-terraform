terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
      version = "2.1.0"
    }
  }
  backend "s3" {
    bucket                      = "arcons-terraform"
    key                         = "terraform.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}

provider "scaleway" {
  region          = "fr-par"
}

module "arcons_k8s" {
  source = "./modules/k8s"
}
