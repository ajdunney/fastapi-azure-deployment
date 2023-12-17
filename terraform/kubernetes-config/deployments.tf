resource "kubernetes_deployment" "fastapi-deployment-v1" {
  metadata {
    name      = "fastapi-deployment-v1"
    namespace = kubernetes_namespace.fastapi.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "fastapi-app"
        version = "v1"
      }
    }
    template {
      metadata {
        labels = {
          app = "fastapi-app"
          version = "v1"
        }
      }
      spec {
        image_pull_secrets {
          name = kubernetes_secret.acr-secret.metadata[0].name
        }
        container {
          name  = "fastiapi-pod"
          image = "${var.acr_name}.azurecr.io/myapi:latest"
          image_pull_policy = "Always"
            port {
                container_port = 80
            }
          env {
            name = "SERVICE_VERSION"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.config_v1.metadata[0].name
                key = "SERVICE_VERSION"
              }
            }
          }
        }  
      }
    }
  }
}

resource "kubernetes_deployment" "fastapi-deployment-v2" {
  metadata {
    name      = "fastapi-deployment-v2"
    namespace = kubernetes_namespace.fastapi.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "fastapi-app"
        version = "v2"
      }
    }
    template {
      metadata {
        labels = {
          app = "fastapi-app"
          version = "v2"
        }
      }
      spec {
        image_pull_secrets {
          name = kubernetes_secret.acr-secret.metadata[0].name
        }
        container {
          name  = "fastiapi-pod"
          image = "${var.acr_name}.azurecr.io/myapi:latest"
          image_pull_policy = "Always"
            port {
                container_port = 80
            }
          env {
            name = "SERVICE_VERSION"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.config_v2.metadata[0].name
                key = "SERVICE_VERSION"
              }
            }
          }
        }  
      }
    }
  }
}
