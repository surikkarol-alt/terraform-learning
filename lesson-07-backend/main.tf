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

data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.tenancy_ocid
}

resource "oci_objectstorage_bucket" "tfstate" {
  compartment_id = var.tenancy_ocid
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = "terraform-state-bucket"
  access_type    = "NoPublicAccess"
}
