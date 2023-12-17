terraform {
  backend "azurerm" {
    resource_group_name  = "deployment-task-tf-rg"
    storage_account_name = "deploymenttasktfstates"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}

provider "azurerm" {
  features {}
}

module "aks-cluster" {
  source       = "./aks-cluster"
  cluster_name = local.cluster_name
  location     = var.location
}

data "azurerm_kubernetes_cluster" "default" {
  depends_on          = [module.aks-cluster]
  name                = local.cluster_name
  resource_group_name = local.resource_group_name
}

module "kubernetes-config" {
  depends_on                      = [module.aks-cluster]
  source                          = "./kubernetes-config"
  cluster_name                    = local.cluster_name
  kubeconfig                      = data.azurerm_kubernetes_cluster.default.kube_config_raw
  acr_name                        = module.aks-cluster.acr_name
  service_principal_client_id     = var.service_principal_client_id
  service_principal_client_secret = var.service_principal_client_secret
}

module "istio" {
  depends_on = [module.aks-cluster, module.kubernetes-config]
  source     = "./istio"
}
