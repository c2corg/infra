module "haproxy" {
  source         = "../../modules/haproxy-ingress"
  chart_version  = var.haproxy_ingress_version
  replica_count  = 1
  enable_metrics = false
}

module "cert-manager" {
  source         = "../../modules/cert-manager"
  chart_version  = var.cert_manager_version
  enable_metrics = false
}

module "kube-prometheus-stack" {
  source            = "../../modules/kube-prometheus-stack"
  chart_version     = var.kube_prometheus_stack_version
  grafana_admin_pwd = var.grafana_admin_pwd
}
