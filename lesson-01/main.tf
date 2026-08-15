terraform {
  required_version = ">= 1.0.0"
}

resource "terraform_data" "hello" {
  input = "Hello DevOps!"
}
