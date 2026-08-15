resource "oci_core_vcn" "main" {
  compartment_id = var.tenancy_ocid
  cidr_block     = "10.0.0.0/16"
  display_name   = "devops-vcn"
  dns_label      = "devopsvcn"

  lifecycle {
    prevent_destroy = true
  }
}

resource "oci_core_internet_gateway" "devops_igw" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "devops-internet-gateway"
  enabled        = true
}

resource "oci_core_route_table" "devops_route_table" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "devops-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.devops_igw.id
  }
}

resource "oci_core_security_list" "devops_security_list" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "devops-security-list"

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "devops_public_subnet" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.main.id

  cidr_block   = "10.0.1.0/24"
  display_name = "devops-public-subnet"
  dns_label    = "public"

  route_table_id = oci_core_route_table.devops_route_table.id

  prohibit_public_ip_on_vnic = false

  security_list_ids = [
    oci_core_security_list.devops_security_list.id
  ]
}
