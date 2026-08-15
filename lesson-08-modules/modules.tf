module "network" {
  source = "./modules/network"

  tenancy_ocid = var.tenancy_ocid
}

module "compute" {
  source = "./modules/compute"

  tenancy_ocid        = var.tenancy_ocid
  subnet_id           = module.network.subnet_id
  ssh_public_key_path = var.ssh_public_key_path
}
