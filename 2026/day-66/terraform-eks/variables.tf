variable "region" {
  type = string
  default = "us-west-2"
}

variable "cluster_name" {
  type = string
  default = "terraweek-eks"
}

variable "cluster_version" {
   type = string
   default = "1.31"
}

variable "node_instance_type" {
   type = string
   default = "m7i-flex.large"
}

variable "node_desired_count" {
   type = number
   default = 2
}

variable "vpc_cidr" {
   type = string
   default = "10.0.0.0/16"
}
