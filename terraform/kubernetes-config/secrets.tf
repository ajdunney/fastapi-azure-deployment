resource "kubernetes_secret" "acr-secret" {
  metadata {
    name = "acr-secret"
    namespace = kubernetes_namespace.fastapi.metadata.0.name
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.acr_name}.azurecr.io" = {
          "username" = var.service_principal_client_id
          "password" = var.service_principal_client_secret
          "auth"     = base64encode(
            "${var.service_principal_client_id}:${var.service_principal_client_secret}"
            )
        }
      }
    })
  }
}