resource "kubernetes_namespace" "fastapi" {
  metadata {
    name = "fastapi-app"
    labels = {
      "istio-injection" = "enabled"
    }
  }
}