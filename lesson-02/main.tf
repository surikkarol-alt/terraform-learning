terraform {
  required_version = ">= 1.0.0"
}

resource "terraform_data" "example" {
  input = var.message
}
