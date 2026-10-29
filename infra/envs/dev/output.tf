
output "server_instance_id" {
  description = "EC2 instance ID"
  value       = module.server.instance_id
}

output "server_public_ip" {
  description = "EC2 public IP address"
  value       = module.server.public_ip
}

output "server_security_group_id" {
  description = "EC2 security group ID"
  value       = module.server.security_group_id
}

output "server_elastic_ip" {
  description = "Elastic IP address of the DevOps server"
  value       = module.server.elastic_ip
}