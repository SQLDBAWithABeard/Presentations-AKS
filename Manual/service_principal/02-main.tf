provider "azurerm" {
  version = "=1.24.0"
}

terraform {
  backend "azurerm" {
    key = "terraform.tfstate"
  }
}

resource "azurerm_azuread_application" "aks_app" {
    name = "${var.sp_name}"
}

resource "azurerm_azuread_service_principal" "aks_sp" {
    application_id = "${azurerm_azuread_application.aks_app.application_id}"
}

resource "random_string" "aks_sp_password" {
    length  = 16
    special = true
    keepers = {
        service_principal = "${azurerm_azuread_service_principal.aks_sp.id}"
    }
}

resource "azurerm_azuread_service_principal_password" "aks_sp_password" {
    service_principal_id = "${azurerm_azuread_service_principal.aks_sp.id}"
    value                = "${random_string.aks_sp_password.result}"
    end_date             = "2019-12-22T00:00:00Z"

    lifecycle {
        ignore_changes = ["end_date"]
    }

    provisioner "local-exec" {
        command = "sleep 30"
    }
}