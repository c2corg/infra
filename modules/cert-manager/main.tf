# Cert manager
resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  namespace        = var.namespace
  create_namespace = true
  skip_crds        = false
  max_history      = 10
  version          = var.chart_version

  set {
    name  = "installCRDs"
    value = true
  }

  set {
    name  = "prometheus.servicemonitor.enabled"
    value = var.enable_metrics
  }

  set {
    name  = "prometheus.servicemonitor.namespace"
    value = var.metrics_namespace
  }
}

# Cluster issuer resource configured with let's encrypt
resource "helm_release" "cert-issuer" {
  name        = "cert-issuer"
  chart       = "${path.module}/chart"
  namespace   = var.namespace
  max_history = 10
  values = [
    file("${path.module}/chart/values.yaml")
  ]

  set {
    name  = "ingressClass"
    value = var.ingress_class
  }
}
