variable "tenancy_ocid" {
  type = string
}

variable "ssh_public_key_path" {
  type    = string
  default = "/home/sharif/.ssh/id_rsa.pub"
}

variable "environment" {
  type = string
}
