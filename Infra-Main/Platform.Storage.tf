

#This is the EAI Data Lake storage account for heirachical namespace message storage
resource "azurerm_storage_account" "platform_storage_eaidatalake" {
  name                      = "${var.general_prefix_lowercase}eaidatalake${var.environment_name_lowercase}"
  location                  = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name       = data.azurerm_resource_group.eai_resource_group.name  
  account_tier             = "Standard"
  account_replication_type = "LRS"
  #allow_blob_public_access  = false
  enable_https_traffic_only = true
  is_hns_enabled            = true
  

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_external    
    scope = "${var.tags_resourcemap_base_scope}\\Platform"
    logicalResource = "${var.general_prefix_lowercase}eaidatalake"
  }
}

