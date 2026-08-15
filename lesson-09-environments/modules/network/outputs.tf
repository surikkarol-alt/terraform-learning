output "vcn_id" {
  value = oci_core_vcn.main.id
}

output "vcn_name" {
  value = oci_core_vcn.main.display_name
}

output "internet_gateway_id" {
  value = oci_core_internet_gateway.devops_igw.id
}

output "route_table_id" {
  value = oci_core_route_table.devops_route_table.id
}

output "security_list_id" {
  value = oci_core_security_list.devops_security_list.id
}

output "subnet_id" {
  value = oci_core_subnet.devops_public_subnet.id
}
