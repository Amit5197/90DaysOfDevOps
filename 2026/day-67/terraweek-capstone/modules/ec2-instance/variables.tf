variable "ami_id" {
  description = "AMI ID used to launch the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}


variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

}

variable "project_name" {
  description = "Project name"
  type        = string

}
