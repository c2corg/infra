resource "helm_release" "c2c-images" {
  name        = "c2c-images"
  chart       = "${path.module}/chart"
  namespace   = "default"
  max_history = 10
  values = [
    file("${path.module}/chart/values.yaml")
  ]

  set {
    name  = "pod.configmap"
    value = kubernetes_config_map.c2c-images-config-map.metadata[0].name
  }
  set {
    name  = "pod.secrets"
    value = kubernetes_secret.c2c-images-secrets.metadata[0].name
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
    name  = "service.port"
    value = var.service_port
  }
  set {
    name  = "service.metricsPort"
    value = var.service_metrics_port
  }
  set {
    name  = "metrics.enabled"
    value = var.enable_metrics
  }

  set {
    name  = "ingress.enabled"
    value = var.enable_ingress
  }
  set {
    name  = "ingress.className"
    value = var.ingress_class
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
    # The name of the cluster issuer to acquire the certificate for this ingress
    # The sub-component ingress-shim watches Ingress resources across your cluster,
    # and on observing the following, it will ensure a certificate resource is created
    name  = "ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = var.cluster_issuer
    type  = "string"
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

  dynamic "set" {
    for_each = var.clean_job_cron != "" ? [var.clean_job_cron] : []
    content {
      name  = "cleanJob.cron"
      value = set.value
    }
  }
}

resource "kubernetes_config_map" "c2c-images-config-map" {
  metadata {
    name = "c2c-images-config-map"
  }
  data = {
    DEBUG                      = "c2c_images:*"
    NODE_ENV                   = var.environment
    VERSION                    = var.image_tag
    METRICS_PORT               = 8081
    SERVICE_PORT               = 8080
    TEMP_FOLDER                = var.temp_folder
    STORAGE_BACKEND            = var.storage_backend
    INCOMING_BUCKET            = var.incoming_bucket
    ACTIVE_BUCKET              = var.active_bucket
    INCOMING_FOLDER            = var.incoming_folder
    ACTIVE_FOLDER              = var.active_folder
    INCOMING_PREFIX            = var.incoming_prefix
    ACTIVE_PREFIX              = var.active_prefix
    RESIZING_CONFIG            = length(var.resizing_config) == 0 ? "" : jsonencode(var.resizing_config)
    AUTO_ORIENT_ORIGINAL       = var.auto_orient_original ? "1" : "0"
    GENERATE_WEBP              = var.generate_webp ? "1" : "0"
    GENERATE_AVIF              = var.generate_avif ? "1" : "0"
    DISABLE_PROMETHEUS_METRICS = var.enable_metrics ? "0" : "1"
  }
}

# Create secret for sensitive data
resource "kubernetes_secret" "c2c-images-secrets" {
  metadata {
    name = "c2c-images-secrets"
  }
  data = merge(var.prefixed_map, {
    API_SECRET_KEY = var.api_secret_key
  })
}
