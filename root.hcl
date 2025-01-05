// generate "backend" {
//   path      = "backend.tf"
//   if_exists = "overwrite"
//   contents  = <<EOT
//   terraform {
//     backend "azurerm" {
//       resource_group_name = "${local.env_vars.backend_rg_name}"
//       storage_account_name = "${local.env_vars.storage_account_name}"
//       container_name = "${local.env_vars.container_name}"
//       key = "${basename(path_relative_to_include())}/terraform.tfstate"
//     }
//   }
//   EOT
// }

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  project_name = local.common_vars.locals.project_name
  environment  = local.env_vars.locals.environment
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOT
  terraform {
    backend "local" {
  }
  }
  EOT
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOT
  terraform {
  required_version = "~>1.8"
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

  provider "azurerm" {
  subscription_id = "9d39a7ed-ade3-48a7-b015-5490cae4f9c5"
  features {}
  }
  EOT
}

inputs = merge(
  local.common_vars.locals,
  local.env_vars.locals,
)
