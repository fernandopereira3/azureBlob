resource "azurerm_storage_account" "arquivosfernando" {
  name                     = "arquivosfernando"
  resource_group_name      = azurerm_resource_group.maquinas-virtuais.name
  location                 = azurerm_resource_group.maquinas-virtuais.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "arquivos-fixos" {
  name                  = "arquivos-fixos"
  storage_account_name  = azurerm_storage_account.arquivosfernando.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "arquivos-backup" {
  name                   = "arquivos-backup"
  storage_account_name   = azurerm_storage_account.arquivosfernando.name
  storage_container_name = azurerm_storage_container.arquivos-fixos.name
  type                   = "Block"
  size                   = "1024"  
}
