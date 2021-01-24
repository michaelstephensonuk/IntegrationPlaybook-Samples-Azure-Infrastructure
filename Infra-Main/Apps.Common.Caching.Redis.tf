
#https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html


resource "azurerm_redis_cache" "platform_cache_general" {
  name                = "${var.general_prefix_lowercase}-eai-cache-${var.environment_name_lowercase}"
  location            = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
 
  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_internal    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\Caching"
    logicalResource = "${var.general_prefix_lowercase}-eai-cache"
  }
}


#Key Vault
#Add the connection string to key vault
#================================================
resource "azurerm_key_vault_secret" "platform_cache_general" {
  name         = "KVS-${var.general_prefix_uppercase}-EAI-Cache-ConnectionString"
  value        = azurerm_redis_cache.platform_cache_general.primary_connection_string 
  key_vault_id = data.azurerm_key_vault.eai_keyvault.id

}