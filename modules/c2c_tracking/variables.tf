variable "environment" {
  type = string
}

variable "image_repository" {
  description = "Docker image repository"
  default     = "c2corg/c2c_tracking"
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

variable "service_port" {
  default = 8080
  type    = number
}

variable "service_metrics_port" {
  type    = number
  default = 8081
}

variable "server_base_url" {
  type = string
}

variable "db_host" {
  default = "localhost"
  type    = string
}

variable "db_name" {
  default = "postgres"
  type    = string
}

variable "db_port" {
  default = 5432
  type    = number
}

variable "db_user" {
  default = "postgres"
  type    = string
}

variable "db_password" {
  default   = "postgres"
  type      = string
  sensitive = true
}

variable "db_enable_ssl" {
  type    = bool
  default = false
}

variable "jwt_secret_key" {
  type      = string
  sensitive = true
}

variable "db_crypto" {
  type      = string
  sensitive = true
}

variable "keyv_connection_uri" {
  type = string
}

variable "frontend_base_url" {
  type = string
}

variable "strava_enabled" {
  type    = bool
  default = true
}

variable "strava_client_id" {
  type = string
}

variable "strava_client_secret" {
  type      = string
  sensitive = true
}

variable "strava_webhook_subscription_verify_token" {
  type      = string
  sensitive = true
}

variable "suunto_enabled" {
  type    = bool
  default = true
}

variable "suunto_client_id" {
  type = string
}

variable "suunto_client_secret" {
  type      = string
  sensitive = true
}

variable "suunto_subscription_key" {
  type      = string
  sensitive = true
}

variable "suunto_webhook_subscription_token" {
  type      = string
  sensitive = true
}

variable "suunto_redirect_uri" {
  default = "trackers/suunto/exchange-token"
  type    = string
}

variable "garmin_enabled" {
  type    = bool
  default = true
}

variable "garmin_consumer_key" {
  type = string
}

variable "garmin_consumer_secret" {
  type      = string
  sensitive = true
}

variable "decathlon_enabled" {
  type    = bool
  default = true
}

variable "decathlon_client_secret" {
  type      = string
  sensitive = true
}

variable "decathlon_api_key" {
  type      = string
  sensitive = true
}

variable "polar_enabled" {
  type    = bool
  default = true
}

variable "polar_client_id" {
  type = string
}

variable "polar_client_secret" {
  type      = string
  sensitive = true
}

variable "coros_enabled" {
  type    = bool
  default = true
}

variable "coros_base_url" {
  type = string
}

variable "coros_client_id" {
  type = string
}

variable "coros_client_secret" {
  type      = string
  sensitive = true
}

variable "mapbox_token" {
  type      = string
  sensitive = true
}

variable "storage_backend" {
  type = string
}

variable "s3_endpoint" {
  type = string
}

variable "s3_region" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "s3_access_key" {
  type = string
}

variable "s3_secret_key" {
  type = string
}

variable "enable_metrics" {
  default = false
  type    = bool
}
