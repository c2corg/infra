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
    name  = "auth.username"
    value = var.postgres_username
  }

  set {
    name  = "auth.password"
    value = var.postgres_password
  }

  set {
    name  = "auth.database"
    value = var.postgres_db
  }

  set {
    name  = "volumPermissions.enabled"
    value = true
  }

  set {
    name  = "primary.persistence.existingClaim"
    value = var.pvc_name
  }
}
