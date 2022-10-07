variable "chart_version" {
  type = string
}

variable "postgres_password" {
  type = string
}

variable "pvc_name" {
  default = ""
  type    = string
}

variable "enable_metrics" {
  default = false
  type    = bool
}

variable "initDbScritps" {
  default = {}
  type    = map(string)
}
