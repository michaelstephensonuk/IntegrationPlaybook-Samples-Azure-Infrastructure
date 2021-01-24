
resource "azurerm_api_management_named_value" "eai_resourcegroup_name" {  
  resource_group_name = azurerm_api_management.platform_apim.resource_group_name
  api_management_name = azurerm_api_management.platform_apim.name

  name                = "eai-resourcegroup-name"
  display_name        = "eai-resourcegroup-name"
  value               = data.azurerm_resource_group.eai_resource_group.name
}

resource "azurerm_api_management_named_value" "eai_subscriptionid" {  
  resource_group_name = azurerm_api_management.platform_apim.resource_group_name
  api_management_name = azurerm_api_management.platform_apim.name

  name                = "eai-subscriptionid"
  display_name        = "eai-subscriptionid"
  value               = data.azurerm_client_config.current.subscription_id
}

resource "azurerm_api_management_named_value" "eai_apim_baseurl" {  
  resource_group_name = azurerm_api_management.platform_apim.resource_group_name
  api_management_name = azurerm_api_management.platform_apim.name

  name                = "eai-apim-baseurl"
  display_name        = "eai-apim-baseurl"
  value               = "https://${azurerm_api_management.platform_apim.name}.azure-api.net"
}
