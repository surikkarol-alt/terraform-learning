output "tenancy_name" {
  value = data.oci_identity_tenancy.current.name
}

# output "availability_domains" {
#  value = data.oci_identity_availability_domains.ads.availability_domains[*].name
# }

output "regions" {
  value = data.oci_identity_regions.regions.regions[*].name
}

output "availability_domain_1" {
  value = data.oci_identity_availability_domain.ad1.name
}

# output "compartment_names" {
#  value = data.oci_identity_compartments.compartments.compartments[*].name
# }

