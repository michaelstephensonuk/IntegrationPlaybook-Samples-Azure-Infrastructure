

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.41.0"
    }
  }
}

provider "azurerm" {    
    skip_provider_registration = true
    features {
    }
}

data "azurerm_client_config" "current" {}


#This is the main resource group that we will manage
resource "azurerm_resource_group" "eai_resource_group" {
  name     = var.eai_resource_group
  location = var.eai_resource_group_location
}



#This is the storage account we will use to store files for the integration platform
resource "azurerm_storage_account" "platform_storage_eai_storage" {
  name                      = "${var.general_prefix_lowercase}${var.environment_name_lowercase}tfintrostorage"
  location                  = azurerm_resource_group.eai_resource_group.location
  resource_group_name       = azurerm_resource_group.eai_resource_group.name  
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true  
}





