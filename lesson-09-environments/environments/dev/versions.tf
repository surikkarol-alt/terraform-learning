terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "8.25.0"
    }
  }

  backend "oci" {
    bucket              = "terraform-state-bucket"
    namespace           = "ax3jv8l9bhh9"
    key                 = "lesson-09/dev/terraform.tfstate"
    region              = "me-dubai-1"
    auth                = "APIKey"
    config_file_profile = "DEFAULT"
  }
}
