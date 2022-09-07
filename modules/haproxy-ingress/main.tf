resource "helm_release" "haproxy_ingress" {
  name             = "haproxy-ingress"
  chart            = "haproxy-ingress"
  repository       = "https://haproxy-ingress.github.io/charts"
  namespace        = var.namespace
  create_namespace = true
  skip_crds        = false
  max_history      = 10
  version          = var.chart_version

  values = [
    file("${path.module}/haproxy-ingress-values.yaml")
  ]

  set {
    name  = "controller.replicaCount"
    value = var.replica_count
  }

  set {
    name  = "controller.metrics.serviceMonitor.enabled"
    value = var.enable_metrics
  }

  set {
    name  = "controller.metrics.enabled"
    value = var.enable_metrics
  }

  set {
    name  = "controller.stats.enabled"
    value = var.enable_metrics
  }

  # Specific annotations are sometimes needed for ressources
  # that are strongly linked to the underlying cloud provider.
  # Which is the case for LoadBalancer type services.
  dynamic "set" {
    for_each = var.loadBalancerAnnotations

    content {
      name  = "controller.service.annotations.${set.key}"
      value = set.value
    }
  }
}
