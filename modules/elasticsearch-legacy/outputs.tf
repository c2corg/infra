output "host" {
  description = "hostname inside k8s"
  value       = "${helm_release.elasticsearch-old.name}.${helm_release.elasticsearch-old.namespace}"
}

output "port" {
  value = 9200
}
