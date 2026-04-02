output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.ec2.public_ip
}

output "private_ip" {
  description = "EC2 Private IP"
  value       = aws_instance.ec2.private_ip
}
