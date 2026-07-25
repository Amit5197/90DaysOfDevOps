variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}
variable "ingress_ports" {
  description = "List of allowed inbound ports"
  type        = list(number)
}
variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
}
variable "project_name" {
  description = "Project name"
  type        = string
}
