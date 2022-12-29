resource "helm_release" "c2c-tracking" {
  name        = "c2c-tracking"
  chart       = "${path.module}/chart"
  namespace   = "default"
  max_history = 10
  values = [
    file("${path.module}/chart/values.yaml")
  ]

  set {
    name  = "pod.configmap"
    value = kubernetes_config_map.c2c-tracking-config-map.metadata[0].name
  }
  set {
    name  = "pod.secrets"
    value = kubernetes_secret.c2c-tracking-secrets.metadata[0].name
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
}

resource "kubernetes_config_map" "c2c-tracking-config-map" {
  metadata {
    name = "c2c-tracking-config-map"
  }
  data = {
    NODE_ENV            = var.environment
    PORT                = 8080
    METRICS_PORT        = 8081
    SERVER_BASE_URL     = var.server_base_url
    DB_HOST             = var.db_host
    DB_NAME             = var.db_name
    DB_PORT             = var.db_port
    DB_ENABLE_SSL       = var.db_enable_ssl
    DB_USER             = var.db_user
    KEYV_CONNECTION_URI = var.keyv_connection_uri
    FRONTEND_BASE_URL   = var.frontend_base_url
    STRAVA_ENABLED      = var.strava_enabled
    STRAVA_CLIENT_ID    = var.strava_client_id
    SUUNTO_ENABLED      = var.suunto_enabled
    SUUNTO_CLIENT_ID    = var.suunto_client_id
    SUUNTO_REDIRECT_URI = var.suunto_redirect_uri
    GARMIN_ENABLED      = var.garmin_enabled
    GARMIN_CONSUMER_KEY = var.garmin_consumer_key
    DECATHLON_ENABLED   = var.decathlon_enabled
    POLAR_ENABLED       = var.polar_enabled
    POLAR_CLIENT_ID     = var.polar_client_id
  }
}

# Create secret for sensitive data
resource "kubernetes_secret" "c2c-tracking-secrets" {
  metadata {
    name = "c2c-tracking-secrets"
  }
  data = {
    DB_PASSWORD                              = var.db_password
    JWT_SECRET_KEY                           = var.jwt_secret_key
    DB_CRYPTO                                = var.db_crypto
    STRAVA_CLIENT_SECRET                     = var.strava_client_secret
    STRAVA_WEBHOOK_SUBSCRIPTION_VERIFY_TOKEN = var.strava_webhook_subscription_verify_token
    SUUNTO_CLIENT_SECRET                     = var.suunto_client_secret
    SUUNTO_SUBSCRIPTION_KEY                  = var.suunto_subscription_key
    SUUNTO_WEBHOOK_SUBSCRIPTION_TOKEN        = var.suunto_webhook_subscription_token
    GARMIN_CONSUMER_SECRET                   = var.garmin_consumer_secret
    DECATHLON_CLIENT_SECRET                  = var.decathlon_client_secret
    DECATHLON_API_KEY                        = var.decathlon_api_key
    POLAR_CLIENT_SECRET                      = var.polar_client_secret
  }
}
