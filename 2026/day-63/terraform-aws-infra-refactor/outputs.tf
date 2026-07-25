output "vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.vpc.id
}

output "subnet_id" {
  description = "Public Subnet Id"
  value       = aws_subnet.public_subnet.id
}

output "instance_id" {
  description = "EC2 Instance Id"
  value       = aws_instance.ec2.id
}

output "instance_public_ip" {
  description = "Public Ip of the EC2 Instance"
  value       = aws_instance.ec2.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 Instance"
  value       = aws_instance.ec2.public_dns
}

output "security_group_id" {
  description = "Security Group Id"
  value       = aws_security_group.ec2-sg.id
}
