output "instance_id" {
  description = "instance id"
  value       = aws_instance.main.id
}

output "security_group_id" {
  description = "security group id"
  value       = aws_security_group.main.id
}
