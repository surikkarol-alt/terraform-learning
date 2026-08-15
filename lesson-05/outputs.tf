output "vcn_id" {
  value = oci_core_vcn.devops_vcn.id
}

output "vcn_name" {
  value = oci_core_vcn.devops_vcn.display_name
}

output "latest_ubuntu_image_name" {
  value = length(data.oci_core_images.ubuntu_images.images) > 0 ? data.oci_core_images.ubuntu_images.images[0].display_name : "NOT FOUND"
}

output "latest_ubuntu_image_id" {
  value     = length(data.oci_core_images.ubuntu_images.images) > 0 ? data.oci_core_images.ubuntu_images.images[0].id : null
  sensitive = true
}

output "available_shape_names" {
  value = data.oci_core_shapes.available_shapes.shapes[*].name
}

output "server_public_ip" {
  value = oci_core_instance.devops_server.public_ip
}

output "server_private_ip" {
  value = oci_core_instance.devops_server.private_ip
}
