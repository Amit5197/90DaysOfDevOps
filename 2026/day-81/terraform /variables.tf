# ==============================================================
# VARIABLES — Configurable inputs for the entire project
# These are like "settings" — change values in terraform.tfvars
# without editing any other file. Defaults are used if tfvars
# doesn't override them.
# ==============================================================

# Which AWS region to deploy in (us-west-2 = Oregon)
variable "aws_region" {
  description = "AWS region for EKS cluster"
  type        = string
  default     = "us-west-2"
}

# Name applied to the EKS cluster and most related resources
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "bankapp-eks"
}

# Kubernetes version to run on EKS
variable "cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.35"
}

# EC2 instance size for worker nodes (controls CPU/RAM per node)
variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

# How many worker nodes to start with
variable "node_desired_count" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 3
}

# Upper limit — auto-scaler will never exceed this count
variable "node_max_count" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 5
}
