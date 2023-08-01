terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.50.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.59.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.18.1"
    }
  }
  required_version = ">= 1.3.1"
}
