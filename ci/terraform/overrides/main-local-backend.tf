terraform {
  backend "local" {
  }

  required_version = ">= 1.4.0"

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.1"
    }
    customopenstack = {
      source  = "gitlab.ics.muni.cz/cloud/openstack"
      version = "~> 0.0.1"
    }
    shell = {
      source = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}
