locals {
  # this is only for demo env, and not exposed to the internet
  postgres_username = "postgresuser"
  postgres_password = "postgrespwd"
  postgres_db       = "postgres"
}

module "postgresql" {
  source        = "../../modules/postgresql"
  chart_version = var.postgresql_version

  postgres_username = local.postgres_username
  postgres_password = local.postgres_password
  pvc_name          = kubernetes_persistent_volume_claim_v1.postgresql.metadata.0.name
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
