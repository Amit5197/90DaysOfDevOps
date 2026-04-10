variable "region" {
  type    = string
  default = "us-west-2"
}

variable "vpc_name" {
  type    = string
  default = "terraweek-vpc"
}

variable "subnet_name" {
  type    = string
  default = "terraweek-subnet"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
