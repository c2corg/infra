variable "chart_version" {
  type    = string
  default = "v1.9.1"
}

variable "enable_metrics" {
  type    = bool
  default = false
}

variable "metrics_namespace" {
  type    = string
  default = "default"
}

variable "namespace" {
  type    = string
  default = "cert-manager"
}

variable "ingress_class" {
  default = "haproxy"
}
