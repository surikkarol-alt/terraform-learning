resource "oci_core_vcn" "imported_vcn" {
  compartment_id = var.tenancy_ocid
  cidr_block     = "10.0.0.0/16"
  display_name   = "devops-vcn"
}
