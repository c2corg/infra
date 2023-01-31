# dns is managed at gandi.net

locals {
  # all k8s services that are accessible from the internet
  # are CNAME dns entries that point to this
  lb_host = "lb.demo.exoscale.infra.camptocamp.org"
  # "unmigrated" demo services are hosted on this VM
  # CNAME entries are used to point to it
  demo_vm = "demo0.exoscale.infra.camptocamp.org"

  domain            = "demov6.camptocamp.org"
  ui_host           = "www.${local.domain}"
  images_host       = "images.${local.domain}"
  api_host          = "api.${local.domain}"
  tracking_host     = "tracking.${local.domain}"
  discourse_host    = "forum.${local.domain}"
  grafana           = "grafana.${local.domain}"
  exoscale_sos_host = "sos-ch-dk-2.exo.io"
}
