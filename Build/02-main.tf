provider "azurerm" {
  version = "=1.24.0"
}

terraform {
  backend "azurerm" {
    key = "terraform.tfstate"
  }
}
locals {
    cluster_name            = "${var.ClusterName}-${random_string.aks.result}"
}

module "service_principal" {
    source    = "service_principal"
    sp_name   = "${local.cluster_name}"
}

resource "azurerm_resource_group" "aks" {
    name     = "${var.ResourceGroupName}"
    location = "${var.location}"
}

resource "random_string" "aks" {
  length  = 4
  lower   = true
  number  = true
  upper   = true
  special = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.cluster_name}"
  location            = "${azurerm_resource_group.aks.location}"
  resource_group_name = "${azurerm_resource_group.aks.name}"
  dns_prefix          = "${local.cluster_name}"
  depends_on          = [
      "module.service_principal"
  ]

  agent_pool_profile {
    name            = "${var.AgentPoolName}"
    count           = "${var.agent_count}"
    vm_size         = "${var.VMSize}"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id       = "${module.service_principal.client_id}"
    client_secret   = "${module.service_principal.client_secret}"
  }

  tags              = {Environment =  "${var.presentation}"}
}

resource "kubernetes_namespace" "Dev" {
  metadata {
    labels {
      mylabel = "Place for Dev"
    }

    name = "Dev"
  }
}

resource "kubernetes_namespace" "Test" {
  metadata {
    labels {
      mylabel = "Place for Test"
    }

    name = "Test"
  }
}

resource "kubernetes_namespace" "Prod" {
  metadata {
    labels {
      mylabel = "Place for Prod"
    }

    name = "Prod"
  }
}

resource "kubernetes_pod" "sql2019" {
  metadata {
    namespace = "${kubernetes_namespace.Dev.name}"
  }

  spec {
    container {
      image = "mcr.microsoft.com/mssql/server:2019-CTP2.4-ubuntu"
      name  = "sql2019"

      env = {
        SA_PASSWORD = "Password0!"
        ACCEPT_EULA = "Y"
      port = 1433

      }
    }
  }
}

resource "kubernetes_service" "sqlserver2019" {
  metadata {
    name = "${var.ServiceName}"
  }
  spec {
    session_affinity = "ClientIP"
    port {
      port = 1433
      target_port = 1433
    }
    type = "LoadBalancer"
  }
}

