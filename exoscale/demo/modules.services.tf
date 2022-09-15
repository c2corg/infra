module "c2c_images" {
  source        = "../../modules/c2c_images"
  replica_count = 1
  image_tag     = var.c2c_images_version
  environment   = var.environment

  enable_ingress = true
  enable_https   = true
  service_hosts  = ["images.demov6.camptocamp.org"]
  cluster_issuer = module.cert-manager.cluster_issuer

  api_secret_key  = var.images_api_secret_key
  temp_folder     = "/srv/images/temp"
  storage_backend = "s3"
  incoming_prefix = "EXO"
  active_prefix   = "EXO"
  incoming_bucket = "c2corg-demov6-incoming"
  active_bucket   = "c2corg-demov6-active"
  prefixed_map = {
    EXO_ENDPOINT      = "https://sos.exo.io"
    EXO_ACCESS_KEY_ID = var.exoscale_api_key
    EXO_SECRET_KEY    = var.exoscale_api_secret
  }
}
