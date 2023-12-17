resource "kubernetes_manifest" "my_virtual_service" {
  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "VirtualService"
    metadata = {
      name      = "my-virtual-service"
      namespace = var.istio_namespace
    }
    spec = {
      hosts = ["*"]
      gateways = ["istio-gateway"] 
      http = [
        {
          match = [
            {
              uri = {
                prefix = "/"
              }
            }
          ]
            route = [
                {
                destination = {
                    host = "fastapi-service.fastapi-app.svc.cluster.local"
                    subset = "v1"
                    port = {
                    number = 80 
                    }
                }
                    weight = 80
                },
                {
                    destination = {
                    host = "fastapi-service.fastapi-app.svc.cluster.local"
                    subset = "v2"
                    port = {
                        number = 80 
                    }
                    }
                    weight = 20
                }
            ]
    }
    ]
  }
}
}

resource "kubernetes_manifest" "grafana" {
    manifest = {
        apiVersion = "networking.istio.io/v1alpha3"
        kind       = "VirtualService"
        metadata = {
        name      = "grafana"
        namespace = var.istio_namespace
        }
        spec = {
        hosts = ["*"]
        gateways = ["istio-gateway"] 
        http = [
            {
            match = [
                {
                uri = {
                    prefix = "/grafana"
                }
                }
            ]
                route = [
                    {
                    destination = {
                        host = "grafana.istio-system.svc.cluster.local"
                        port = {
                        number = 3000 
                        }
                    }
                        weight = 100
                    }
                ]
        }
        ]
    }
    }
  
}