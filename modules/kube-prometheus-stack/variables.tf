variable "grafana_admin_pwd" {
  type = string
}

variable "enable_ingress" {
  type    = bool
  default = false
}

variable "ingress_annotations" {
  type    = map(any)
  default = {}
}

variable "ingress_host" {
  type    = string
  default = ""
}

variable "enable_https" {
  type    = bool
  default = false
}

variable "grafana_env" {
  type    = map(any)
  default = {}
}

variable "grafana_pvc_name" {
  type    = string
  default = ""
}

variable "chart_version" {
  default = "40.0.0"
}

variable "namespace" {
  type    = string
  default = "kube-prometheus-stack"
}
