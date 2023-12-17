variable "cluster_name" {
  type = string
  default = "azurerm-kubernetes-cluster"
}

variable "acr_name" {
  type = string
}

variable "service_principal_client_id" {
  type = string
}

variable "service_principal_client_secret" {
  type = string
}