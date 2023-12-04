terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.53.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
  required_version = ">= 1.3.1"
}
