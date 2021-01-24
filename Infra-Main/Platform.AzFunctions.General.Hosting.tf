

#Function App Service Host
#General consumption based host for Function Apps.  Expect most of our function apps will live on this
#======================================================================================================

resource "azurerm_app_service_plan" "platform_azfunctions_general_hosting" {
  name                = "${var.general_prefix_lowercase}-eai-functions-${var.environment_name_lowercase}"
  location            = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }


  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_internal    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\Functions"
    logicalResource = "${var.general_prefix_lowercase}-eai-functions"
  }
}

#This is the generic storage account we can use with function apps.  We will typically share a stroage account unless a specific app
#needs its own storage
resource "azurerm_storage_account" "platform_azfunctions_general_storage" {
  name                      = "${var.general_prefix_lowercase}eaifunctions${var.environment_name_lowercase}"
  location                  = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name       = data.azurerm_resource_group.eai_resource_group.name
  account_tier              = "Standard"
  account_replication_type  = "LRS"

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_internal    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\Functions"
    logicalResource = "${var.general_prefix_lowercase}eaifunctions"
  }
}

#The application insights instance which will be used by functions
resource "azurerm_application_insights" "platform_azfunctions_general_application_insights" {
  name                = "${var.general_prefix_lowercase}-eai-functions-${var.environment_name_lowercase}"
  location            = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name
  application_type    = "web"

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_internal    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\Functions"
    logicalResource = "${var.general_prefix_lowercase}-eai-functions"
  }
}
