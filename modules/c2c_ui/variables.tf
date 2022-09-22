variable "image_repository" {
  description = "Docker image repository"
  default     = "c2corg/c2c_ui"
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "replica_count" {
  type    = number
  default = 2
}

variable "service_hosts" {
  description = "list of the hostnames that will be used for routing requests from the load balancer / ingress to the service"
  type        = list(string)
}

variable "enable_ingress" {
  default = true
}

variable "ingress_class" {
  default = "haproxy"
}

variable "cluster_issuer" {
  type = string
}

variable "enable_https" {
  default = true
}

variable "service_port" {
  type    = number
  default = 8080
}

variable "min_cpu" {
  description = "Requested cpu. Set to 0 to remove constraint"
  type        = number
  default     = 300
}

variable "min_memory" {
  description = "Requested memory. Set to 0 to remove constraint"
  type        = number
  default     = 256
}

variable "max_cpu" {
  description = "Max cpu. Set to 0 to remove constraint"
  type        = number
  default     = 0
}

variable "max_memory" {
  description = "Max memory. Set to 0 to remove constraint"
  type        = number
  default     = 0
}
