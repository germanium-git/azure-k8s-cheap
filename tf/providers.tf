terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            
        }
    }
    cloud {
        organization = "mygermanium"

        workspaces {
            name = "azure-k8s-cheap"
        }
    }
}


provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

