locals {
  environment = terraform.workspace
  name_prefix = "${var.project_name}-${local.environment}"

  # Define configuration per workspace
  env_config = {
    dev = {
      vpc_cidr      = "10.0.0.0/16"
      subnet_cidr   = "10.0.1.0/24"
      instance_type = "t2.micro"
      ingress_ports = [22, 80]
    }
    staging = {
      vpc_cidr      = "10.1.0.0/16"
      subnet_cidr   = "10.1.1.0/24"
      instance_type = "t2.small"
      ingress_ports = [22, 80, 443]
    }
    prod = {
      vpc_cidr      = "10.2.0.0/16"
      subnet_cidr   = "10.2.1.0/24"
      instance_type = "t3.small"
      ingress_ports = [80, 443]
    }
  }

  # Fetch parameters for the active workspace (falls back to dev)
  current_env   = lookup(local.env_config, local.environment, local.env_config["dev"])
  vpc_cidr      = local.current_env.vpc_cidr
  subnet_cidr   = local.current_env.subnet_cidr
  instance_type = local.current_env.instance_type
  ingress_ports = local.current_env.ingress_ports

  common_tags = {
    Project     = var.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Workspace   = terraform.workspace
  }
}
