terraform {
  required_version = ">= 1.0"

  required_providers {
    helm = {
      version = ">= 2.2.0"
      source  = "hashicorp/helm"
    }
  }
}
