provider "exoscale" {
  key    = var.exoscale_api_key
  secret = var.exoscale_api_secret
}

provider "kubernetes" {
  host                   = yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).clusters[0].cluster.server
  cluster_ca_certificate = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).clusters[0].cluster.certificate-authority-data)
  client_certificate     = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).users[0].user.client-key-data)
}

provider "helm" {
  kubernetes {
    host                   = yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).clusters[0].cluster.server
    cluster_ca_certificate = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).clusters[0].cluster.certificate-authority-data)
    client_certificate     = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).users[0].user.client-certificate-data)
    client_key             = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).users[0].user.client-key-data)
  }
}

# Use aws provider to manage exoscale object storage
provider "aws" {
  endpoints {
    s3 = "https://sos-${var.default_zone}.exo.io"
  }
  region     = var.default_zone
  access_key = var.exoscale_api_key
  secret_key = var.exoscale_api_secret
  # Skip AWS validations
  skip_credentials_validation = true
  skip_get_ec2_platforms      = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true

}
