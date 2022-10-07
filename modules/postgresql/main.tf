resource "helm_release" "postgres" {
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  name       = "postgresql"
  namespace  = "default"
  version    = var.chart_version

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "auth.postgresPassword"
    value = var.postgres_password
  }

  set {
    name  = "volumPermissions.enabled"
    value = true
  }

  set {
    name  = "primary.persistence.existingClaim"
    value = var.pvc_name
  }

  set {
    name  = "metrics.enabled"
    value = var.enable_metrics
  }

  set {
    name  = "metrics.serviceMonitor.enabled"
    value = var.enable_metrics
  }

  dynamic "set" {
    for_each = var.initDbScritps

    content {
      name  = "primary.initdb.scripts.${set.key}"
      value = set.value
    }
  }
}
