terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.52.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
  required_version = ">= 1.3.1"
}
