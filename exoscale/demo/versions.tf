terraform {
  required_providers {
    exoscale = {
      version = "0.48.0"
      source  = "exoscale/exoscale"
    }
    aws = {
      version = "= 4.59.0"
      source  = "hashicorp/aws"
    }
    helm = {
      version = "= 2.9.0"
      source  = "hashicorp/helm"
    }
    kubernetes = {
      version = "= 2.18.1"
      source  = "hashicorp/kubernetes"
    }
  }
  required_version = ">= 1.3.1"
}
