variable "chart_version" {
  type = string
}

variable "postgres_username" {
  type = string
}

variable "postgres_password" {
  type = string
}

variable "postgres_db" {
  type    = string
  default = "postgres"
}

variable "pvc_name" {
  default = ""
  type    = string
}
