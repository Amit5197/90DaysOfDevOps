module "vpc"{
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  cidr = var.vpc_cidr
  azs  = ["us-west-2a", "us-west-2b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true 
  public_subnet_tags = {
  "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = 1
  }

}


