provider "exoscale" {
  key    = var.exoscale_api_key
  secret = var.exoscale_api_secret
}

provider "helm" {
  kubernetes {
    host                   = yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).clusters[0].cluster.server
    cluster_ca_certificate = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).clusters[0].cluster.certificate-authority-data)
    client_certificate     = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).users[0].user.client-certificate-data)
    client_key             = base64decode(yamldecode(exoscale_sks_kubeconfig.c2c.kubeconfig).users[0].user.client-key-data)
  }
}
