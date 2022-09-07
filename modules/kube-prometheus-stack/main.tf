# The Prometheus Operator provides Kubernetes native deployment and management of Prometheus
# and related monitoring components (grafana, alert manager, ...)
resource "helm_release" "kube_prometheus_stack" {
  name        = "kube-prometheus-stack"
  chart       = "kube-prometheus-stack"
  repository  = data.helm_repository.prometheus_community.metadata[0].url
  namespace   = "default"
  version     = var.chart_version
  max_history = 10

  values = [
    file("${path.module}/kube-prometheus-stack-values.yaml")
  ]
  set {
    name  = "grafana.adminPassword"
    value = var.grafana_admin_pwd
  }
  dynamic "set" {
    for_each = var.grafana_env
    content {
      name  = "grafana.env.${set.key}"
      value = set.value
      type  = "string"
    }
  }
  dynamic "set" {
    for_each = var.enable_ingress == true ? [1] : []
    content {
      name  = "grafana.ingress.enabled"
      value = true
    }
  }
  dynamic "set" {
    for_each = var.grafana_pvc_name == "" ? [] : [1]
    content {
      name  = "grafana.persistence.enabled"
      value = true
    }
  }
  dynamic "set" {
    for_each = var.grafana_pvc_name == "" ? [] : [var.grafana_pvc_name]
    content {
      name  = "grafana.persistence.existingClaim"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = var.enable_ingress == true ? var.ingress_annotations : {}
    content {
      name  = "grafana.ingress.annotations.${set.key}"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = var.enable_ingress == true ? [1] : []
    content {
      name  = "grafana.ingress.hosts[0]"
      value = var.ingress_host
    }
  }
  dynamic "set" {
    for_each = var.enable_https == true ? [1] : []
    content {
      name  = "grafana.ingress.tls[0].hosts[0]"
      value = var.ingress_host
    }
  }
  dynamic "set" {
    for_each = var.enable_https == true ? [1] : []
    content {
      name  = "grafana.ingress.tls[0].secretName"
      value = "grafana-cert"
    }
  }
}

data "helm_repository" "prometheus_community" {
  name = "prometheus-community"
  url  = "https://prometheus-community.github.io/helm-charts"
}
