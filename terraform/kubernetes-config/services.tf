resource "kubernetes_service" "fastapi-service-v1" {
  metadata {
    name = "fastapi-service-v1"
    namespace = kubernetes_namespace.fastapi.metadata.0.name
  }
  spec {
    selector = {
      app = "fastapi-app-v1"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_service" "fastapi-service-v2" {
  metadata {
    name = "fastapi-service-v2"
    namespace = kubernetes_namespace.fastapi.metadata.0.name
  }
  spec {
    selector = {
      app = "fastapi-app-v2"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}