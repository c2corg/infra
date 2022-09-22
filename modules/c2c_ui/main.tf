resource "helm_release" "c2c-ui" {
  name        = "c2c-ui"
  chart       = "${path.module}/chart"
  namespace   = "default"
  max_history = 10
  values = [
    file("${path.module}/chart/values.yaml")
  ]

  set {
    name  = "pod.configmap"
    value = kubernetes_config_map.c2c-ui-config-map.metadata[0].name
  }

  set {
    name  = "image.repository"
    value = var.image_repository
  }
  set {
    name  = "image.tag"
    value = var.image_tag
  }
  set {
    name  = "replicaCount"
    value = var.replica_count
  }

  set {
    name  = "service_port"
    value = var.service_port
  }

  set {
    name  = "ingress.enabled"
    value = var.enable_ingress
  }
  set {
    name  = "ingress.tls"
    value = var.enable_https
  }
  dynamic "set" {
    for_each = var.service_hosts
    content {
      name  = "ingress.hosts[${set.key}].host"
      value = set.value
    }
  }
  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "haproxy"
  }
  set {
    # The name of the cluster issuer to acquire the certificate for this ingress
    # The sub-component ingress-shim watches Ingress resources across your cluster,
    # and on observing the following, it will ensure a certificate resource is created
    name  = "ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = var.cluster_issuer
    type  = "string"
  }
  set {
    # nginx is configured with proxy protocol
    name  = "ingress.annotations.ingress\\.kubernetes\\.io/proxy-protocol"
    value = "v2"
  }

  dynamic "set" {
    for_each = var.min_cpu > 0 ? [var.min_cpu] : []
    content {
      name  = "resources.requests.cpu"
      value = "${set.value}m"
    }
  }
  dynamic "set" {
    for_each = var.min_memory > 0 ? [var.min_memory] : []
    content {
      name  = "resources.requests.memory"
      value = "${set.value}Mi"
    }
  }
  dynamic "set" {
    for_each = var.max_cpu > 0 ? [var.max_cpu] : []
    content {
      name  = "resources.limits.cpu"
      value = "${set.value}m"
    }
  }
  dynamic "set" {
    for_each = var.max_memory > 0 ? [var.max_memory] : []
    content {
      name  = "resources.limits.memory"
      value = "${set.value}Mi"
    }
  }
}

resource "kubernetes_config_map" "c2c-ui-config-map" {
  metadata {
    name = "c2c-ui-config-map"
  }
  data = {
    PORT        = var.service_port
    SERVER_NAME = join(" ", var.service_hosts)
  }
}
