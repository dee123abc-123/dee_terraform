output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.allow_ssh_http.id
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}
