resource "helm_release" "elasticsearch-old" {
  name        = "elasticsearch-old"
  chart       = "${path.module}/chart"
  namespace   = "default"
  max_history = 10
  values = [
    file("${path.module}/chart/values.yaml")
  ]

  set {
    name  = "image.tag"
    value = var.elasticsearch_version
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  dynamic "set" {
    for_each = var.es_heap_size != "" ? [var.es_heap_size] : []
    content {
      name  = "heapSize"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.pvc_name != "" ? [var.pvc_name] : []
    content {
      name  = "persistence.existingClaim"
      value = set.value
    }
  }
}
