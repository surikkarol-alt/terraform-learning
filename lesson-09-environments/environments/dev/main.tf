module "network" {
  source = "../../modules/network"

  tenancy_ocid = var.tenancy_ocid
  environment  = var.environment
}

module "compute" {
  source = "../../modules/compute"

  tenancy_ocid        = var.tenancy_ocid
  subnet_id           = module.network.subnet_id
  ssh_public_key_path = var.ssh_public_key_path
  cloud_init_path     = "${path.root}/cloud-init.yaml"
  environment         = var.environment

  shape         = "VM.Standard.A1.Flex"
  ocpus         = 1
  memory_in_gbs = 6
}
