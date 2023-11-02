terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = "mra-test-aes-net-rg"
  location = "Australia East"
  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
}


### add some new features here, so we can make it better
### new notes
###
###
