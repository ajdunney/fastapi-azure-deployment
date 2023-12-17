variable "cluster_name" {
  default = "azurerm-kubernetes-cluster"
}

variable "location" {
  default = "uksouth"
}

variable "resource_group_name" {
  default = "deployment-task-rg"
}

variable "container_registry_name" {
  default = "deploymenttaskacr"
}