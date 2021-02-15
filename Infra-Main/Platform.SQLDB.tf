
#Key Vault Secret for the SQL Server Admin User
data "azurerm_key_vault_secret" "platform_eai_sql_svr_admin_username" {
  name         = "EAI-SQL-Server-Admin-Username"
  key_vault_id = data.azurerm_key_vault.eai_keyvault.id
}

#Key Vault Secret for the SQL Server Admin Password
data "azurerm_key_vault_secret" "platform_eai_sql_svr_admin_password" {
  name         = "EAI-SQL-Server-Admin-Password"
  key_vault_id = data.azurerm_key_vault.eai_keyvault.id
}


#Storage account used for SQL audit logs
resource "azurerm_storage_account" "platform_sqldb_server_audit" {
  name                     = "${var.general_prefix_lowercase}eaisqlsvr${var.environment_name_lowercase}"
  location                 = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name      = data.azurerm_resource_group.eai_resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#Logical Server for Azure SQL
resource "azurerm_mssql_server" "platform_sqldb_server" {
  name                = "${var.general_prefix_lowercase}-eai-sql-svr-${var.environment_name_lowercase}"
  location            = data.azurerm_resource_group.eai_resource_group.location
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name
  version             = "12.0"

  administrator_login          = data.azurerm_key_vault_secret.platform_eai_sql_svr_admin_username.value
  administrator_login_password = data.azurerm_key_vault_secret.platform_eai_sql_svr_admin_password.value


  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_external    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\Data"
    logicalResource = "${var.general_prefix_lowercase}-eai-sql-svr"
  }
}

#Audit policy for the server
resource "azurerm_mssql_server_extended_auditing_policy" "platform_sqldb_server_audit" {
  server_id                               = azurerm_mssql_server.platform_sqldb_server.id
  storage_endpoint                        = azurerm_storage_account.platform_sqldb_server_audit.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.platform_sqldb_server_audit.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

# Using the ip range below will allow access to the SQLDB by Azure Services
resource "azurerm_sql_firewall_rule" "allow_all_azure_ips" {
  name                = "AllowAllAzureIps"
  resource_group_name = azurerm_mssql_server.platform_sqldb_server.resource_group_name
  server_name		  = azurerm_mssql_server.platform_sqldb_server.name

  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}


#General purpose SQL database for use in the integration platform
resource "azurerm_sql_database" "platform_sqldb" {
  name							= "eai_sql_db-${var.environment_name_lowercase}"
  resource_group_name			= azurerm_mssql_server.platform_sqldb_server.resource_group_name
  location						= azurerm_mssql_server.platform_sqldb_server.location
  server_name					= azurerm_mssql_server.platform_sqldb_server.name

  #The tiers are listed with - az sql db list-editions -l westus -o table
  edition						   = "Basic"
  requested_service_objective_name = "Basic"

  tags = {    
    environment = var.environment_name_lowercase
    project = var.tags_project_all
    managedBy = var.tags_managed_by
    costCentre = var.tags_cost_centre_eai    
    dataProfile = var.tags_dataprofile_external    
    scope = "${var.tags_resourcemap_base_scope}\\Platform\\Data"
    logicalResource = "${var.general_prefix_lowercase}-eai-sql-db"
  }
  
}