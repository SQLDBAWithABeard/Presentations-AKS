provider "azurerm" {
  subscription_id = "2d31be49-d999-4415-bb65-8aec2c90ba62"
  client_id       = "cf34389a-839e-42a9-8201-9a5bed151767"
  client_secret   = "923ea4d9-829a-4477-9650-7a11c4a680f3"
  tenant_id       = "72f988bf-8691-41af-91ab-2d7cd011db47"
}
provider "kubernetes" {
    version                 = "~> 1.3"
    host                    = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
    client_certificate      = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)}"
    client_key              = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)}"
    cluster_ca_certificate  = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)}"
}