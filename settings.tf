terraform {
  # local state file must be used for the first run
  backend "s3" {}
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "~> 1.10"
    }
  }
}
