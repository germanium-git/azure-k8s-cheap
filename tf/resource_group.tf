# Create resource group for k8s cluster
resource "azurerm_resource_group" "main" {
  name     = "rg-${local.name}-k8s-cheap"
  location = var.location
}

