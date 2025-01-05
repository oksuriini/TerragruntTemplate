include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/_modules/module1/infra"
}

include "commonvars" {
  path   = "${dirname(find_in_parent_folders("root.hcl"))}/common.hcl"
  expose = true
}

inputs = {
  address_space = ["10.0.0.0/16"]
}
