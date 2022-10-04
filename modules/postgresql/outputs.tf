output "host" {
  description = "hostname inside k8s"
  value       = "${helm_release.postgres.name}.${helm_release.postgres.namespace}"
}

output "port" {
  value = 5432
}
