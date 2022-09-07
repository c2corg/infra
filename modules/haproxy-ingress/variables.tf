variable "loadBalancerAnnotations" {
  type        = map(any)
  description = "Map of annotations to add to the LoadBalancer service"
  default     = {}
}

variable "chart_version" {
  type    = string
  default = "0.13.19"
}

variable "replica_count" {
  type    = number
  default = 2
}

variable "enable_metrics" {
  type    = bool
  default = true
}

variable "namespace" {
  type    = string
  defautl = "haproxy-ingress"
}
