

#This is the event hub will receive events from systems in the factory which will be processed into the EAI platform
resource "azurerm_eventhub" "app_factoryevents_eventhub_fromfactoryapp" {
  name                = "factoryevents-from-factorysystems"
  namespace_name      = azurerm_eventhub_namespace.platform_azurerm_eventhub_namespace_main.name
  resource_group_name = azurerm_eventhub_namespace.platform_azurerm_eventhub_namespace_main.resource_group_name
  partition_count     = 1
  message_retention   = 7
}

resource "azurerm_eventhub_authorization_rule" "app_factoryevents_eventhub_fromfactoryapp" {
  name                = "Factory-Systems"
  namespace_name      = azurerm_eventhub.app_factoryevents_eventhub_fromfactoryapp.namespace_name
  resource_group_name = azurerm_eventhub.app_factoryevents_eventhub_fromfactoryapp.resource_group_name
  eventhub_name       = azurerm_eventhub.app_factoryevents_eventhub_fromfactoryapp.name
  listen              = false
  send                = true
  manage              = false
}

resource "azurerm_key_vault_secret" "app_factoryevents_eventhub_fromfactoryapp" {
  name         = "KVS-EventHub-FactoryEvents-Factory-Systems-Key"
  value        = azurerm_eventhub_authorization_rule.app_factoryevents_eventhub_fromfactoryapp.primary_key
  key_vault_id = data.azurerm_key_vault.eai_keyvault.id
}

