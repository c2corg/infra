variable "rabbitmq_host" {
  type = list(string)
}

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
  default = "11.1.1"
}

variable "namespace" {
  type    = string
  defautl = "kube-prometheus-stack"
}
