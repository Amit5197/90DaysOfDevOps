output "vpc_id" {
  description = "Vpc Id"
  value       = aws_vpc.vpc.id
}

output "subnet_id" {
  description = "Public Subnet Id"
  value       = aws_subnet.public_subnet.id
}
