output "message_output" {
  description = "Output value from terraform_data"
  value       = terraform_data.example.output
}

output "server_name" {
  value = var.server_name
}

output "cpu_count" {
  value = var.cpu_count
}

output "monitoring_enabled" {
  value = var.monitoring_enabled
}

output "allowed_ports" {
  value = var.allowed_ports
}

output "server_tags" {
  value = var.server_tags
}
