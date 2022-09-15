variable "exoscale_api_key" {
  type = string
}

variable "exoscale_api_secret" {
  type = string
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
}

variable "c2c_images_version" {
  type = string
}

variable "kube_prometheus_stack_version" {
  type = string
}

variable "grafana_admin_pwd" {
  type = string
}

variable "cert_manager_version" {
  type = string
}

variable "haproxy_ingress_version" {
  type = string
}
