resource "helm_release" "haproxy_ingress" {
  name             = "haproxy-ingress"
  chart            = "kubernetes-ingress"
  repository       = "https://haproxytech.github.io/helm-charts"
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
    name  = "serviceMonitor.enabled"
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
