variable "exoscale_api_key" {
  type      = string
  sensitive = true
}

variable "exoscale_api_secret" {
  type      = string
  sensitive = true
}

variable "environment" {
  type = string
}

variable "default_zone" {
  type = string
}

variable "enable_metrics" {
  type = bool
}

variable "images_api_secret_key" {
  description = "Secret shared between v6_api and c2c_images"
  type        = string
  sensitive   = true
}

variable "c2c_images_version" {
  type = string
}

variable "c2c_ui_version" {
  type = string
}

variable "c2c_tracking_version" {
  type = string
}

variable "v6_api_version" {
  type = string
}

variable "postgresql_chart_version" {
  type = string
}

variable "longhorn_chart_version" {
  type = string
}

variable "kube_prometheus_stack_chart_version" {
  type = string
}

variable "redis_chart_version" {
  type = string
}

variable "elasticsearch_version" {
  type = string
}

variable "grafana_admin_pwd" {
  type      = string
  sensitive = true
}

variable "cert_manager_chart_version" {
  type = string
}

variable "haproxy_kubernetes_ingress_chart_version" {
  type = string
}

variable "jwt_secret_key" {
  type      = string
  sensitive = true
}

variable "db_crypto" {
  type      = string
  sensitive = true
}

variable "strava_client_secret" {
  type      = string
  sensitive = true
}

variable "strava_webhook_subscription_verify_token" {
  type      = string
  sensitive = true
}

variable "suunto_client_secret" {
  type      = string
  sensitive = true
}

variable "suunto_subscription_key" {
  type      = string
  sensitive = true
}

variable "suunto_webhook_subscription_token" {
  type      = string
  sensitive = true
}

variable "garmin_consumer_secret" {
  type      = string
  sensitive = true
}

variable "decathlon_client_secret" {
  type      = string
  sensitive = true
}

variable "decathlon_api_key" {
  type      = string
  sensitive = true
}

variable "polar_client_secret" {
  type      = string
  sensitive = true
}

variable "mapbox_token" {
  type      = string
  sensitive = true
}

variable "mail_password" {
  type      = string
  sensitive = true
}

variable "recaptcha_secret_key" {
  type      = string
  sensitive = true
}