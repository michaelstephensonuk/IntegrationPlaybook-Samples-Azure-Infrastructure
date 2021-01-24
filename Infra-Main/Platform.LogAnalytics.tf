

resource "azurerm_log_analytics_workspace" "platform_loganalytics_workspace" {
  name                = "${var.general_prefix_lowercase}-eai-logs-${var.environment_name_lowercase}"
  location            = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_internal    
    scope = "${var.tags_resourcemap_base_scope}\\Platform"
    logicalResource = "${var.general_prefix_lowercase}-eai-logs"
  }
}


#Save the log analytics workspace key to key vault
resource "azurerm_key_vault_secret" "platform_loganalytics_workspace_primarykey" {
  name         = "KVS-LogAnalytics-PrimaryKey"
  value        = azurerm_log_analytics_workspace.platform_loganalytics_workspace.primary_shared_key
  key_vault_id = data.azurerm_key_vault.eai_keyvault.id
}

#Save the log analytics workspace id to key vault
resource "azurerm_key_vault_secret" "platform_loganalytics_workspace_id" {
  name         = "KVS-LogAnalytics-Id"
  value        = azurerm_log_analytics_workspace.platform_loganalytics_workspace.workspace_id
  key_vault_id = data.azurerm_key_vault.eai_keyvault.id
}