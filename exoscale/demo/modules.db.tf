locals {
  # this is only for demo env, and not exposed to the internet
  postgres_password = "postgrespwd"
  api_db_name       = "c2corg"
  api_db_user       = "c2corg"
  api_db_pwd        = "c2corg"
  tracking_db_name  = "c2corg_tracking"
  tracking_db_user  = "tracking"
  tracking_db_pwd   = "tracking"
}

# Postgresql is used by both tracking and api

module "postgresql" {
  source        = "../../modules/postgresql"
  chart_version = var.postgresql_chart_version

  postgres_password = local.postgres_password
  pvc_name          = kubernetes_persistent_volume_claim_v1.postgresql.metadata.0.name

  enable_metrics = var.enable_metrics

  initDbScritps = {
    # Create tracking user and database
    "tracking\\.sql" = <<EOT
CREATE USER ${local.tracking_db_user} WITH PASSWORD '${local.tracking_db_pwd}';
CREATE DATABASE '${local.tracking_db_name}';
GRANT ALL PRIVILEGES ON DATABASE '${local.tracking_db_name}' TO '${local.tracking_db_user}';
EOT
    # Create api user and database
    "api\\.sql" = <<EOT
CREATE USER '${local.api_db_user}' WITH PASSWORD '${local.api_db_pwd}';
CREATE DATABASE '${local.api_db_name}';
GRANT ALL PRIVILEGES ON DATABASE '${local.api_db_name}' TO '${local.api_db_user}';
EOT
    # Enable postgis (postgis is included in bitnami image)
    "postgis\\.sql" = "CREATE EXTENSION postgis;"
  }
}

resource "kubernetes_persistent_volume_claim_v1" "postgresql" {
  metadata {
    name = "postgresql"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "20Gi"
      }
    }
    storage_class_name = "longhorn"
  }
}

# Redis is used by the api as queue to notify the syncer script of changed
# documents and also as cache

module "redis" {
  source        = "../../modules/redis"
  chart_version = var.redis_chart_version

  enable_metrics = var.enable_metrics
}
