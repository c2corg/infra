# ingress controller
module "haproxy" {
  source        = "../../modules/haproxy-ingress"
  chart_version = var.haproxy_ingress_version
  replica_count = 1
}

# tls certificates generation and renewal
module "cert-manager" {
  source        = "../../modules/cert-manager"
  chart_version = var.cert_manager_version
}

# monitoring
module "kube-prometheus-stack" {
  source            = "../../modules/kube-prometheus-stack"
  chart_version     = var.kube_prometheus_stack_version
  grafana_admin_pwd = var.grafana_admin_pwd
  enable_ingress    = false
}

# provide persistent volume capability to exoscale
module "longhorn" {
  source        = "../../modules/longhorn"
  chart_version = var.longhorn_version
}
