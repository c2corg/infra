resource "helm_release" "redis" {
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "redis"
  name             = "redis"
  namespace        = "default"
  version          = var.chart_version
  create_namespace = true
  skip_crds        = false

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "metrics.enabled"
    value = var.enable_metrics
  }

  set {
    name  = "metrics.serviceMonitor.enabled"
    value = var.enable_metrics
  }
}
