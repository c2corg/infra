terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.57.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.44.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.28.0"
    }
  }
  required_version = ">= 1.3.1"
}
