terraform {
  required_providers {
    exoscale = {
      version = ">= 0.40.1"
      source  = "exoscale/exoscale"
    }
    aws = {
      version = ">= 4.29.0"
      source  = "hashicorp/aws"
    }
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
