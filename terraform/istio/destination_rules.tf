resource "kubernetes_manifest" "my_destination_rule_v1" {
  depends_on = [helm_release.istiod]
  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "DestinationRule"
    metadata = {
      name      = "my-destination-rule-v1"
      namespace = var.istio_namespace
    }
    spec = {
      host = "fastapi-service-v1.fastapi-app.svc.cluster.local"
      subsets = [
        {
          name   = "v1"
          labels = {
            version = "v1"
          }
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "my_destination_rule_v2" {
  depends_on = [helm_release.istiod]
  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "DestinationRule"
    metadata = {
      name      = "my-destination-rule-v2"
      namespace = var.istio_namespace
    }
    spec = {
      host = "fastapi-service-v2.fastapi-app.svc.cluster.local"
      subsets = [
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
