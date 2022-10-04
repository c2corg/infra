resource "helm_release" "postgres" {
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  name             = "longhorn"
  namespace        = "longhorn-system"
  version          = var.chart_version
  create_namespace = true
  skip_crds        = false
}
