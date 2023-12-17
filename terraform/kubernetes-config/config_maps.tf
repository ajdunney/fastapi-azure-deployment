resource "kubernetes_config_map" "config_v1" {
  metadata {
    name = "fastapi-config-v1"
    namespace = kubernetes_namespace.fastapi.metadata.0.name
  }
  data = {
    "SERVICE_VERSION" = "1.0"
  }
}

resource "kubernetes_config_map" "config_v2" {
  metadata {
    name = "fastapi-config-v2"
    namespace = kubernetes_namespace.fastapi.metadata.0.name
  }
  data = {
    "SERVICE_VERSION" = "2.0"
  }
}