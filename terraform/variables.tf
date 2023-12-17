variable "location" {
  default = "uksouth"
}

variable "service_principal_client_id" {
  type = string
}

variable "service_principal_client_secret" {
  type = string
}

locals {
  cluster_name        = "azurerm-kubernetes-cluster"
  resource_group_name = "deployment-task-rg"
}

