


resource "azurerm_eventhub_namespace" "platform_azurerm_eventhub_namespace_main" {
  name                = "${var.general_prefix_lowercase}-eai-eventhub-${var.environment_name_lowercase}"
  location            = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name
  sku                 = "Standard"
  capacity            = 1


  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_external    
    scope = "${var.tags_resourcemap_base_scope}\\Platform"
    logicalResource = "${var.general_prefix_lowercase}-eai-eventhub"
  }
}