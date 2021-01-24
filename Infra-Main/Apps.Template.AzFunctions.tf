

resource "azurerm_function_app" "template_functions" {
  name                          = "${var.general_prefix_lowercase}-azfunc-template-${var.environment_name_lowercase}"
  location                      = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name           = data.azurerm_resource_group.eai_resource_group.name
  app_service_plan_id           = azurerm_app_service_plan.platform_azfunctions_general_hosting.id
  storage_account_name          = azurerm_storage_account.platform_azfunctions_general_storage.name
  storage_account_access_key    = azurerm_storage_account.platform_azfunctions_general_storage.primary_access_key
  https_only		            = true
  version                       = "~3"

  site_config {    
    scm_type                 = "None"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.platform_azfunctions_general_application_insights.instrumentation_key    
    "AzureWebJobsStorage" = azurerm_storage_account.platform_azfunctions_general_storage.primary_connection_string
    "AzureWebJobs.Ping.Disabled" = "false"
    "WEBSITE_RUN_FROM_PACKAGE" = 1
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
    "FUNCTIONS_EXTENSION_VERSION" = "~3"
    "WEBSITE_CONTENTSHARE" = azurerm_storage_account.platform_azfunctions_general_storage.name
    "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = azurerm_storage_account.platform_azfunctions_general_storage.primary_connection_string
    "AzureWebJobsSecretStorageType" = "files"
  }

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_internal    
    scope = "${var.tags_resourcemap_base_scope}\\Templates\\Functions"
    logicalResource = "${var.general_prefix_lowercase}-azfunc-template"
  }


    
}


#Get the host key for the function
#================================================
data "azurerm_function_app_host_keys" "template_functions" {
  name                = azurerm_function_app.template_functions.name
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name

  depends_on = [
    azurerm_function_app.template_functions
  ]
}

#Key Vault
#Add the secret to key vault for the function app
#================================================
resource "azurerm_key_vault_secret" "template_functions_FunctionKey" {
  name         = "KVS-${var.general_prefix_uppercase}-azfunc-template-FunctionKey"
  value        = data.azurerm_function_app_host_keys.template_functions.default_function_key 
  key_vault_id = data.azurerm_key_vault.eai_keyvault.id

}