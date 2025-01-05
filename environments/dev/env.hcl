locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOT
  terraform {
    backend "azurerm" {
      resource_group_name = "${local.env_vars.backend_rg_name}"
      storage_account_name = "${local.env_vars.storage_account_name}"
      container_name = "${local.env_vars.container_name}"
      key = "${basename(path_relative_to_include())}/terraform.tfstate"
    }
  }
  EOT
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOT
  terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.15.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.26.0"
    }
  }
  }

  EOT
}
