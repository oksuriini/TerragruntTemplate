module "rg" {
  source       = "../../../_modules/module1/infra/"
  environment  = var.environment
  project_name = var.project_name
}
