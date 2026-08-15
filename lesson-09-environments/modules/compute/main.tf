data "oci_core_images" "ubuntu_images" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = var.shape

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
  display_name        = "${var.environment}-devops-server"
  shape               = var.shape
  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
    display_name     = "${var.environment}-devops-vnic"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_images.images[0].id
  }

  metadata = {
    ssh_authorized_keys = local.ssh_public_key
    user_data           = base64encode(file(var.cloud_init_path))
  }
}
