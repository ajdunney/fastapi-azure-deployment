resource "kubernetes_manifest" "my_destination_rule" {
  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "DestinationRule"
    metadata = {
      name      = "my-destination-rule"
      namespace = var.istio_namespace
    }
    spec = {
      host = "fastapi-service.fastapi-app.svc.cluster.local"
      subsets = [
        {
          name   = "v1"
          labels = {
            version = "v1"
          }
        },
        {
          name   = "v2"
          labels = {
            version = "v2"
          }
        }
      ]
    }
  }
}