module "network" {
  source = "../../modules/network"

  project     = var.project
  subnets     = var.subnets
  admin_cidrs = var.admin_cidrs
}

module "compute" {
  source = "../../modules/compute"

  project             = var.project
  subnet_ids          = module.network.subnet_ids
  security_group_id   = module.network.security_group_id
  ssh_user            = var.ssh_user
  ssh_public_key_path = var.ssh_public_key_path
  masters             = var.masters
  workers             = var.workers
}

module "balancer" {
  source = "../../modules/balancer"

  project = var.project
  targets = module.compute.worker_targets

}