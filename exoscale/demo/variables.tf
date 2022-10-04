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

variable "postgresql_version" {
  type = string
}

variable "longhorn_version" {
  type = string
}

variable "kube_prometheus_stack_version" {
  type = string
}

variable "grafana_admin_pwd" {
  type      = string
  sensitive = true
}

variable "cert_manager_version" {
  type = string
}

variable "haproxy_ingress_version" {
  type = string
}
