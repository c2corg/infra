terraform {
  required_providers {
    helm = {
      version = ">= 2.6.0"
      source  = "hashicorp/helm"
    }
    kubernetes = {
      version = ">= 2.13.1"
      source  = "hashicorp/kubernetes"
    }
  }
  required_version = ">= 1.0"
}
