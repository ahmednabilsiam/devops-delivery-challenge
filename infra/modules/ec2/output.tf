
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IPv4 address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.this.id
}

output "elastic_ip" {
  description = "Elastic IP address of the EC2 instance"
  value       = aws_eip.this.public_ip
}