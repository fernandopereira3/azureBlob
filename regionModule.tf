module "regions_default" {
  source  = "Azure/regions/azurerm//examples/default"
  version = "0.5.2"
}

resource "random_integer" "region_index" {
  min = 0
  max = length(module.regions_default.regions) - 1
}


output "random_region" {
  value = module.regions_default.regions[random_integer.region_index.result]
}