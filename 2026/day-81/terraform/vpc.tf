# ==============================================================
# VPC (Virtual Private Cloud)
# Creates an isolated network where all EKS resources live.
# Uses the official AWS VPC module to create 9 subnets across 3 AZs:
#   - Public subnets  (10.0.1-3.0/24) → for internet-facing Load Balancers
#   - Private subnets (10.0.4-6.0/24) → for worker nodes (hidden from internet)
#   - Intra subnets   (10.0.7-9.0/24) → for EKS control plane ENIs (fully isolated)
# Also creates a NAT Gateway so private nodes can download Docker images
# without being directly reachable from the internet.
# ==============================================================

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name            = local.name
  cidr            = local.vpc_cidr
  azs             = local.azs
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
  intra_subnets   = local.intra_subnets

  enable_nat_gateway = true

# public subnets for external (internet-facing) load balancers
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
# private subnets for internal load balancers
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}
