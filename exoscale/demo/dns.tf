# dns is managed at gandi.net

locals {
  domain = "demov6.camptocamp.org"

  images_host = "images.${local.domain}"
  ui_host     = "www.${local.domain}"
  api_host    = "api.${local.domain}"
}
