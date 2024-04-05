resource "azurerm_virtual_network" "rede001" {
  name                = "rede001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.maquinas-virtuais.location
  resource_group_name = azurerm_resource_group.maquinas-virtuais.name
}

resource "azurerm_subnet" "subnet001" {
  name                 = "subnet001"
  resource_group_name  = azurerm_resource_group.maquinas-virtuais.name
  virtual_network_name = azurerm_virtual_network.rede001.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "rede1" {
  name                = "rede-nic"
  location            = azurerm_resource_group.maquinas-virtuais.location
  resource_group_name = azurerm_resource_group.maquinas-virtuais.name

  ip_configuration {
    name                          = "configuration1"
    subnet_id                     = azurerm_subnet.subnet001.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "maquina001" {
  name                  = "maquina001-vm"
  location              = azurerm_resource_group.maquinas-virtuais.location
  resource_group_name   = azurerm_resource_group.maquinas-virtuais.name
  network_interface_ids = [azurerm_network_interface.rede1.id]
  vm_size               = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "server"
    admin_username = "ubuntu"
    admin_password = "${var.senha}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "Testes"
  }
}