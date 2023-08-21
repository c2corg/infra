terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.51.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.59.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
  required_version = ">= 1.3.1"
}
