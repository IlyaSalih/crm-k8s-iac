module "network" {
  source = "../../modules/network"

  project     = var.project
  zone        = var.zone
  subnet_cidr = var.subnet_cidr
}