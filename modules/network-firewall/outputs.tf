output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "public subnet id"
  value       = aws_subnet.public.id
}
