module "images" {
  source        = "../../modules/c2c_images"
  replica_count = 1
  image_tag     = var.c2c_images_version
  environment   = var.environment

  enable_ingress = true
  enable_https   = true
  service_hosts  = [local.images_host]
  cluster_issuer = module.cert-manager.cluster_issuer

  enable_metrics = var.enable_metrics

  api_secret_key       = var.images_api_secret_key
  storage_backend      = "s3"
  incoming_prefix      = "EXO"
  active_prefix        = "EXO"
  incoming_bucket      = aws_s3_bucket.incoming.bucket
  active_bucket        = aws_s3_bucket.active.bucket
  generate_webp        = true
  generate_avif        = true
  auto_orient_original = true
  prefixed_map = {
    EXO_ENDPOINT      = "https://${local.exoscale_sos_host}"
    EXO_ACCESS_KEY_ID = var.exoscale_api_key
    EXO_SECRET_KEY    = var.exoscale_api_secret
  }
  cors_allowed_origins = "*"

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

module "tracking" {
  source        = "../../modules/c2c_tracking"
  replica_count = 1
  image_tag     = var.c2c_tracking_version
  environment   = var.environment

  enable_ingress = true
  enable_https   = true
  service_hosts  = [local.tracking_host]
  cluster_issuer = module.cert-manager.cluster_issuer

  enable_metrics = var.enable_metrics

  server_base_url                          = "https://${local.tracking_host}/"
  db_host                                  = module.postgresql.host
  db_port                                  = module.postgresql.port
  db_name                                  = local.tracking_db_name
  db_user                                  = local.tracking_db_user
  db_enable_ssl                            = false
  db_password                              = local.tracking_db_pwd
  db_crypto                                = var.db_crypto
  keyv_connection_uri                      = "redis://${module.redis.host}:${module.redis.port}/"
  jwt_secret_key                           = var.jwt_secret_key
  frontend_base_url                        = "https://${local.ui_host}/"
  strava_enabled                           = false
  strava_client_id                         = "99246"
  strava_client_secret                     = var.strava_client_secret
  strava_webhook_subscription_verify_token = var.strava_webhook_subscription_verify_token
  suunto_enabled                           = false
  suunto_client_id                         = "2928e564-85eb-4aef-92fb-2a0259589c9c"
  suunto_client_secret                     = var.suunto_client_secret
  suunto_subscription_key                  = var.suunto_subscription_key
  suunto_webhook_subscription_token        = var.suunto_webhook_subscription_token
  garmin_enabled                           = true
  garmin_consumer_key                      = "f6af0bcb-ed47-4383-90e8-46351c764d4b"
  garmin_consumer_secret                   = var.garmin_consumer_secret
  decathlon_enabled                        = false
  decathlon_client_secret                  = var.decathlon_client_secret
  decathlon_api_key                        = var.decathlon_api_key
  polar_enabled                            = true
  polar_client_id                          = "65d10592-5abf-41d6-a5ce-b16a28174849"
  polar_client_secret                      = var.polar_client_secret
}
