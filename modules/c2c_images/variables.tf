variable "environment" {
  type = string
}

variable "image_repository" {
  description = "Docker image repository"
  default     = "c2corg/c2c_images"
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

variable "metrics_port" {
  type    = number
  default = 8081
}

variable "storage_backend" {
  type = string
}

variable "temp_folder" {
  type = string
}

variable "incoming_bucket" {
  default = ""
}

variable "active_bucket" {
  default = ""
}

variable "incoming_folder" {
  default = ""
}

variable "active_folder" {
  default = ""
}

variable "incoming_prefix" {
  default = ""
}

variable "active_prefix" {
  default = ""
}

variable "api_secret_key" {
  type = string
}

variable "prefixed_map" {
  type    = map(string)
  default = {}
}

variable "min_cpu" {
  description = "Requested cpu. Set to 0 to remove constraint"
  type        = number
  default     = 0
}

variable "min_memory" {
  description = "Requested memory. Set to 0 to remove constraint"
  type        = number
  default     = 0
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

variable "clean_job_cron" {
  description = "Set the cron value if you want the clean job to regularly delete expired images from the incoming bucket"
  type        = string
  default     = ""
}
