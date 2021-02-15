
#Platform cosmos account for nosql data used in the integration platform
resource "azurerm_cosmosdb_account" "platform_cosmosdb_account_sql" {
  name                      = "${var.general_prefix_lowercase}-eai-cosmossql-${var.environment_name_lowercase}"
  location                  = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name       = data.azurerm_resource_group.eai_resource_group.name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = true

  capabilities {
    name = "EnableServerless"
  }
  
  consistency_policy {
    consistency_level       = "Eventual"
    
  }

  geo_location {
    location          = data.azurerm_resource_group.eai_resource_group.location
    failover_priority = 0
  }

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_external    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\Data"
    logicalResource = "${var.general_prefix_lowercase}-eai-cosmossql"
  }
}


#Registers a default database in cosmos for us to use for general purpose things
resource "azurerm_cosmosdb_sql_database" "platform_cosmosdb_sqldb" {
  name                = "eai-database"
  resource_group_name = azurerm_cosmosdb_account.platform_cosmosdb_account_sql.resource_group_name
  account_name        = azurerm_cosmosdb_account.platform_cosmosdb_account_sql.name  
}

#Creates a general purpose container for the configuration data we might want to support interfaces
resource "azurerm_cosmosdb_sql_container" "platform_cosmos_collection_config" {
  name                  = "eai-config-data"

  resource_group_name   = azurerm_cosmosdb_sql_database.platform_cosmosdb_sqldb.resource_group_name
  account_name          = azurerm_cosmosdb_sql_database.platform_cosmosdb_sqldb.account_name  
  database_name         = azurerm_cosmosdb_sql_database.platform_cosmosdb_sqldb.name

  partition_key_path    = "/definition/id"
  partition_key_version = 1

  indexing_policy {
    indexing_mode = "Consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}