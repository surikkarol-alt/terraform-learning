output "vcn_id" {
  value = module.network.vcn_id
}

output "vcn_name" {
  value = module.network.vcn_name
}

output "latest_ubuntu_image_name" {
  value = module.compute.latest_ubuntu_image_name
}

output "latest_ubuntu_image_id" {
  value     = module.compute.latest_ubuntu_image_id
  sensitive = true
}

output "available_shape_names" {
  value = module.compute.available_shape_names
}

output "server_public_ip" {
  value = module.compute.public_ip
}

output "server_private_ip" {
  value = module.compute.private_ip
}
