variable "region" {
  description = "Region to create resources"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "subnet cidr block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "Type of ec2 instance"
  type        = string
  default     = "t3.micro"
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "allowed_ports" {
  description = "Ports"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "extra_tags" {
  description = "tags"
  type        = string
  default     = "{}"
}
