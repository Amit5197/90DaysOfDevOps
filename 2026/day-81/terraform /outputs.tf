# ==============================================================
# OUTPUTS — Values printed after "terraform apply" finishes
# Useful for:
#   - Connecting kubectl to the cluster
#   - Referencing in CI/CD pipelines
#   - Quick copy-paste helper commands
# ==============================================================

# Cluster identity and connection info
# Cluster
output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Kubernetes version running on the cluster"
  value       = module.eks.cluster_version
}

# Marked sensitive — won't print in plain text (use "terraform output -json")
output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data for cluster authentication"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

# Needed if you want to create more IRSA roles later (e.g., S3, DynamoDB)
output "oidc_provider_arn" {
  description = "OIDC provider ARN (for IRSA if needed)"
  value       = module.eks.oidc_provider_arn
}

# Network IDs — useful for adding more resources to the same VPC
# Networking
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs (worker nodes)"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnet IDs (load balancers)"
  value       = module.vpc.public_subnets
}

# Copy-paste these into your terminal after apply
# Quick commands
output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${local.region}"
}

output "argocd_initial_password" {
  description = "Command to get ArgoCD initial admin password"
  value       = "kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d"
}
