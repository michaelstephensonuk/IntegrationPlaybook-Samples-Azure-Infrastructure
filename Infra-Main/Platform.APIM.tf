
#The APIM instance which will be setup for the platform
resource "azurerm_api_management" "platform_apim" {
  name                = "${var.general_prefix_lowercase}-apim-${var.environment_name_lowercase}"

  location            = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name
  publisher_name      = "My Company"
  publisher_email     = "apim@mikestephenson.me"

  sku_name = "Consumption_0"

  identity {
    type = "SystemAssigned"
  }
  

  policy {
    xml_content = <<XML
    <policies>
      <inbound />
      <backend />
      <outbound />
      <on-error />
    </policies>
XML

  }

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_internal    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\APIM"
    logicalResource = "${var.general_prefix_lowercase}-apim"
  }
}


#Add the application insights instance that our APIM will use
resource "azurerm_application_insights" "platform_apim_appinsights" {
  name                = "${var.general_prefix_lowercase}-ai-apim-${var.environment_name_lowercase}"
  location            = azurerm_api_management.platform_apim.location
  resource_group_name = azurerm_api_management.platform_apim.resource_group_name
  application_type    = "web"

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_internal    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\APIM"
    logicalResource = "${var.general_prefix_lowercase}-ai-apim"
  }
}


#Add the logger in APIM which will make APIM log to our app insights
resource "azurerm_api_management_logger" "platform_apim_appinsights_logger" {
  name                = "${var.general_prefix_lowercase}-ai-apim-${var.environment_name_lowercase}"
  api_management_name = azurerm_api_management.platform_apim.name
  resource_group_name = azurerm_api_management.platform_apim.resource_group_name

  application_insights {
    instrumentation_key = azurerm_application_insights.platform_apim_appinsights.instrumentation_key
  }
}