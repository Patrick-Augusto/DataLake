provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "datalake" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storageaccountmetastore" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.datalake.name
  location                 = azurerm_resource_group.datalake.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "logs" {
  name                  = "$logs"
  storage_account_name  = azurerm_storage_account.storageaccountmetastore.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "bronze" {
  name                  = "bronze"
  storage_account_name  = azurerm_storage_account.storageaccountmetastore.name
  container_access_type = "private"
} 

resource "azurerm_storage_container" "silver" {
  name                  = "silver"
  storage_account_name  = azurerm_storage_account.storageaccountmetastore.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "gold" {
  name                  = "gold"
  storage_account_name  = azurerm_storage_account.storageaccountmetastore.name
  container_access_type = "private"
}

resource "azurerm_key_vault" "datalake_key_vault" {
  name                     = var.key_vault_name
  resource_group_name      = azurerm_resource_group.datalake.name
  location                 = azurerm_resource_group.datalake.location
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
}

resource "azurerm_data_factory" "datalake_data_factory" {
  name                = var.data_factory_name
  resource_group_name = azurerm_resource_group.datalake.name
  location            = azurerm_resource_group.datalake.location
}

resource "azurerm_databricks_workspace" "adb_workspace_test" {
  name                = var.databricks_workspace_name
  resource_group_name = azurerm_resource_group.datalake.name
  location            = azurerm_resource_group.datalake.location
  sku                 = "standard"
}

resource "azurerm_databricks_access_connector" "access_connector_adb" {
  name                = var.databricks_access_connector_name
  resource_group_name = azurerm_resource_group.datalake.name
  location            = azurerm_resource_group.datalake.location
}
