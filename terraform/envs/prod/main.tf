module "network" {
  source = "../../modules/network"

  project     = var.project
  subnets     = var.subnets
  admin_cidrs = var.admin_cidrs
}