# ==============================================================
# PROVIDER CONFIGURATION
# Sets up which plugins (providers) Terraform uses, shared
# constants (locals), and how to authenticate with AWS and Helm.
# ==============================================================

# Pin Terraform CLI and provider versions to avoid breaking changes
terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
  }
}

# Shared constants used by all other .tf files
# Define once here, reference everywhere as "local.xxx"
# Contains: region, cluster name, VPC CIDR, subnet ranges, AZs, tags
locals {
  region          = var.aws_region
  name            = var.cluster_name
  vpc_cidr        = "10.0.0.0/16"
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  intra_subnets   = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]

  tags = {
    Project     = "AI-BankApp"
    ManagedBy   = "terraform"
    Environment = "production"
  }
}

# Fetches all AWS Availability Zones that are already enabled
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# AWS Provider — tells Terraform how to talk to AWS APIs
provider "aws" {
  region = local.region
}

# Helm Provider — tells Terraform how to install Helm charts on EKS
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}
