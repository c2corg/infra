output "host" {
  description = "hostname inside k8s"
  value       = "${helm_release.redis.name}.${helm_release.redis.namespace}"
}

output "port" {
  value = 6379
}
