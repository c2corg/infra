module "images" {
  source        = "../../modules/c2c_images"
  replica_count = 1
  image_tag     = var.c2c_images_version
  environment   = var.environment

  enable_ingress = true
  enable_https   = true
  service_hosts  = [local.images_host]
  cluster_issuer = module.cert-manager.cluster_issuer

  api_secret_key  = var.images_api_secret_key
  temp_folder     = "/srv/images/temp"
  storage_backend = "s3"
  incoming_prefix = "EXO"
  active_prefix   = "EXO"
  incoming_bucket = aws_s3_bucket.incoming.bucket
  active_bucket   = aws_s3_bucket.active.bucket
  prefixed_map = {
    EXO_ENDPOINT      = "https://sos.exo.io"
    EXO_ACCESS_KEY_ID = var.exoscale_api_key
    EXO_SECRET_KEY    = var.exoscale_api_secret
  }

  # exoscale doesn't support object lifecycle management,
  # the clean script will remove expired images from the
  # incoming bucket, every day at 04:07 UTC
  clean_job_cron = "7 4 * * *"
}

module "ui" {
  source        = "../../modules/c2c_ui"
  replica_count = 1
  image_tag     = var.c2c_ui_version

  enable_ingress = true
  enable_https   = true
  service_hosts  = [local.ui_host]
  cluster_issuer = module.cert-manager.cluster_issuer
}
