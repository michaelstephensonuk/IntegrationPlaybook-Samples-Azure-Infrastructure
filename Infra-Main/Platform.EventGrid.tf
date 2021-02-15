

resource "azurerm_eventgrid_domain" "platform_eventgrid_domain" {
  name                = "${var.general_prefix_lowercase}-eai-eventgrid-${var.environment_name_lowercase}"
  location            = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_external    
    scope = "${var.tags_resourcemap_base_scope}\\Platform"
    logicalResource = "${var.general_prefix_lowercase}-eai-eventgrid"
  }
}