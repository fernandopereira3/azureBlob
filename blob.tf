resource "azurerm_resource_group" "files" {
  name     = "files"
  location = "East US"
}

resource "azurerm_storage_account" "backupfiles0001" {
  name                     = "backupfiles0001"
  resource_group_name      = azurerm_resource_group.files.name
  location                 = azurerm_resource_group.files.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "arquivos-fixos" {
  name                  = "arquivos-fixos"
  storage_account_name  = azurerm_storage_account.backupfiles0001.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "arquivos-backup" {
  name                   = "arquivos-backup"
  storage_account_name   = azurerm_storage_account.backupfiles0001.name
  storage_container_name = azurerm_storage_container.arquivos-fixos.name
  type                   = "Block"
  size                   = "1024"
}
