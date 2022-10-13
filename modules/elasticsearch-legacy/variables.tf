variable "elasticsearch_version" {
  default = "2.4.6-alpine"
}

variable "cluster_name" {
  default = "c2corg"
}

variable "es_heap_size" {
  default = ""
}

variable "pvc_name" {
  default = ""
}
