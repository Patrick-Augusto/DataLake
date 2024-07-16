variable "location" {
  description = "The Azure region to deploy resources into"
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "DataLake"
}
 
variable "storage_account_name" {
  description = "The name of the storage account"
  default     = "storageaccountmetastore"
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  default     = "DataLakeProjectKey"
}

variable "data_factory_name" {
  description = "The name of the Data Factory"
  default     = "DataLakeProject"
}

variable "databricks_workspace_name" {
  description = "The name of the Databricks Workspace"
  default     = "adb-workspace-test"
}

variable "databricks_access_connector_name" {
  description = "The name of the Databricks Access Connector"
  default     = "access_connector_adb"
}
