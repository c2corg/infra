# dns is managed at gandi.net

locals {
  domain            = "demov6.camptocamp.org"
  images_host       = "images.${local.domain}"
  ui_host           = "www.${local.domain}"
  api_host          = "api.${local.domain}"
  discourse_host    = "forum.${local.domain}"
  grafana           = "grafana.${local.domain}"
  exoscale_sos_host = "sos.exo.io"
}
