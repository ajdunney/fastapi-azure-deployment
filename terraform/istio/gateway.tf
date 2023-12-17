
resource "helm_release" "istio_ingress_gateway" {
  name       = "istio-ingress-gateway"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  namespace  = "istio-ingress"
  create_namespace = true
  version = "1.17.1"

  set {
    name  = "global.istiod.enabled"
    value = "true"
  }

  depends_on = [helm_release.istio, helm_release.istiod]
}

resource "kubernetes_manifest" "istio_gateway" {
    manifest = {
        apiVersion = "networking.istio.io/v1alpha3"
        kind       = "Gateway"
        metadata = {
            name      = "istio-gateway"
            namespace =  var.istio_namespace
        }
    spec = {
      selector = {
        istio = "ingress-gateway"
      }
      servers = [
        {
          port = {
            number   = 80
            name     = "http"
            protocol = "HTTP"
          }
          hosts = ["*"]
        }
      ]
    }
  }
}
