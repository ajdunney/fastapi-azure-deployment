resource "helm_release" "istio" {
  name       = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  namespace  = var.istio_namespace
  create_namespace = true
  version          = "1.17.1"
} 

resource "helm_release" "istiod" {
  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  namespace  = var.istio_namespace
  version    = "1.17.1"

  set {
    name  = "global.istioNamespace"
    value = "istio-system"
  }

  depends_on = [helm_release.istio]
}