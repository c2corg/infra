terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.51.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
  }
  required_version = ">= 1.3.1"
}
