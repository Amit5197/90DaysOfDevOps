output "vpc_id" {
  description = "virtual private cloud id"
  value       = aws_vpc.my-vpc.id
}
output "subnet_id" {
  description = "subnet id"
  value       = aws_subnet.my-subnet.id
}
output "instance_id" {
  description = "ec2 instance id"
  value       = aws_instance.my-ec2.id
}
output "instance_public_ip" {
  description = "ec2 instance public ip"
  value       = aws_instance.my-ec2.public_ip
}
output "instance_public_dns" {
  description = "ec2 instance public dns"
  value       = aws_instance.my-ec2.public_dns
}
output "security_group_id" {
  description = "security group id"
  value       = aws_security_group.sg.id
}