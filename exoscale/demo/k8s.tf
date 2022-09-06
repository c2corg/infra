resource "exoscale_sks_cluster" "c2c" {
  zone          = var.default_zone
  name          = "${var.environment}-cluster"
  service_level = "starter"
}

output "my_sks_cluster_endpoint" {
  value = exoscale_sks_cluster.c2c.endpoint
}
