# ingress controller
module "haproxy" {
  source         = "../../modules/haproxy-ingress"
  chart_version  = var.haproxy_kubernetes_ingress_chart_version
  replica_count  = 1
  enable_metrics = var.enable_metrics
}

# tls certificates generation and renewal
module "cert-manager" {
  source         = "../../modules/cert-manager"
  chart_version  = var.cert_manager_chart_version
  enable_metrics = var.enable_metrics
}

# monitoring
module "kube-prometheus-stack" {
  source            = "../../modules/kube-prometheus-stack"
  chart_version     = var.kube_prometheus_stack_chart_version
  grafana_admin_pwd = var.grafana_admin_pwd
  enable_ingress    = false
}

# provide persistent volume capability to exoscale
module "longhorn" {
  source        = "../../modules/longhorn"
  chart_version = var.longhorn_chart_version
}
