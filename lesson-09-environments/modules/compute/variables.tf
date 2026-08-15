variable "tenancy_ocid" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "cloud_init_path" {
  type = string
}

variable "environment" {
  type = string
}

variable "shape" {
  type = string
}

variable "ocpus" {
  type    = number
  default = 1
}

variable "memory_in_gbs" {
  type    = number
  default = 6
}
