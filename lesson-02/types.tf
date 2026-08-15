variable "server_name" {
  type    = string
  default = "devops-server"
}

variable "cpu_count" {
  type    = number
  default = 2
}

variable "monitoring_enabled" {
  type    = bool
  default = true
}

variable "allowed_ports" {
  type    = list(number)
  default = [22, 80, 443]
}

variable "server_tags" {
  type = map(string)

  default = {
    environment = "development"
    project     = "monitor-bot"
    managed_by  = "terraform"
  }
}
