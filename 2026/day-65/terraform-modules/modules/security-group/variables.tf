variable "vpc_id" {
  description = "VPC ID"
  type        = string
}


variable "sg_name" {
  description = "Security Group Name"
  type        = string
}

variable "ingress_ports" {
  description = "List of allowed ingress ports"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
