terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "8.25.0"
    }
  }
}

provider "oci" {
  config_file_profile = "DEFAULT"
}

variable "tenancy_ocid" {
  type = string
}

resource "oci_core_vcn" "devops_vcn" {
  compartment_id = var.tenancy_ocid
  cidr_block     = "10.0.0.0/16"
  display_name   = "devops-vcn"
  dns_label      = "devopsvcn"
}

resource "oci_core_internet_gateway" "devops_igw" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.devops_vcn.id
  display_name   = "devops-internet-gateway"
  enabled        = true
}

resource "oci_core_route_table" "devops_route_table" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.devops_vcn.id
  display_name   = "devops-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.devops_igw.id
  }
}

resource "oci_core_subnet" "devops_public_subnet" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.devops_vcn.id

  cidr_block   = "10.0.1.0/24"
  display_name = "devops-public-subnet"
  dns_label    = "public"

  route_table_id = oci_core_route_table.devops_route_table.id

  prohibit_public_ip_on_vnic = false

  security_list_ids = [
    oci_core_security_list.devops_security_list.id
  ]
}

resource "oci_core_security_list" "devops_security_list" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.devops_vcn.id
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

data "oci_core_images" "ubuntu_images" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = "VM.Standard.E2.1.Micro"

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}

data "oci_core_shapes" "available_shapes" {
  compartment_id      = var.tenancy_ocid
  availability_domain = "uSOm:ME-DUBAI-1-AD-1"
}

locals {
  ssh_public_key = file(var.ssh_public_key_path)
}

resource "oci_core_instance" "devops_server" {
  compartment_id      = var.tenancy_ocid
  availability_domain = "uSOm:ME-DUBAI-1-AD-1"
  display_name        = "terraform-devops-server"
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = oci_core_subnet.devops_public_subnet.id
    assign_public_ip = true
    display_name     = "terraform-devops-vnic"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_images.images[0].id
  }

  metadata = {
    ssh_authorized_keys = local.ssh_public_key
    user_data           = base64encode(file("${path.module}/cloud-init.yaml"))
  }
}

