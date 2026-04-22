# ==============================================================
# EKS CLUSTER
# Creates:
#   1. EKS control plane (managed by AWS — API server, etcd, scheduler)
#   2. Managed node group (EC2 worker nodes where pods run)
#   3. 6 add-ons: coredns, kube-proxy, vpc-cni, pod-identity,
#      ebs-csi-driver, metrics-server
#   4. IAM role (IRSA) for the EBS CSI driver
# Uses EKS module v21.x with Kubernetes 1.35, AL2023 AMI,
# EKS Pod Identity, access_entries, and AWS provider v6.0+
# ==============================================================

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # v21 parameter names (renamed from v20)
  name               = local.name
  kubernetes_version = var.cluster_version

  # public = kubectl works from your laptop; private = node traffic stays in VPC
  endpoint_public_access  = true
  endpoint_private_access = true

  # Cluster creator gets admin access via access_entries
  enable_cluster_creator_admin_permissions = true

  # EKS Add-ons (latest versions auto-resolved)
  # coredns       → DNS inside cluster (pods find services by name)
  # kube-proxy    → routes traffic from Services to the right Pod
  # vpc-cni       → gives each pod a real VPC IP address
  # pod-identity  → lets pods assume AWS IAM roles securely
  # ebs-csi       → lets pods use EBS disk volumes (MySQL, Ollama data)
  # metrics-server→ powers "kubectl top" and HPA auto-scaling
  # "before_compute = true" installs the add-on BEFORE nodes join
  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
    }
    eks-pod-identity-agent = {
      most_recent    = true
      before_compute = true
    }
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_irsa.iam_role_arn
    }
    metrics-server = {
      most_recent = true
    }
  }

  # Networking — workers in private subnets, control plane ENIs in intra subnets
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  # Managed Node Group — AWS handles OS patches, AMI updates, and node draining
  # 3 nodes at start (min 3, max 5), each running m7i-flex.large (2 vCPU, 8 GB)
  eks_managed_node_groups = {
    bankapp-ng = {
      instance_types = [var.node_instance_type]
      desired_size   = var.node_desired_count
      min_size       = var.node_desired_count
      max_size       = var.node_max_count

      tags = {
        NodeGroup = "bankapp"
      }
    }
  }

  tags = local.tags
}

# IRSA (IAM Role for Service Accounts) — EBS CSI Driver permissions
# Gives the EBS CSI pod an IAM role to create/attach EBS volumes
module "ebs_csi_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name             = "${local.name}-ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = local.tags
}
