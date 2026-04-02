# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Data source to get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}


# Locals for common values and tags
locals {
  common_tags = {
    Owner     = "Sanket Dangat"
    ManagedBy = "Terraform"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  #   version = "~> 5.0"
  version = ">=5.0, <6.0"

  name = "terraweek-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway   = false
  enable_dns_hostnames = true

  tags = local.common_tags
}

module "web_sg" {
  source = "./modules/security-group"
  #   vpc_id        = aws_vpc.main.id
  vpc_id        = module.vpc.vpc_id
  sg_name       = "terraweek-web-sg"
  ingress_ports = [22, 80, 443]
  tags          = local.common_tags
}

module "web_server" {
  source        = "./modules/ec2-instance"
  ami_id        = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"
  #   subnet_id          = aws_subnet.public.id
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-web"
  tags               = local.common_tags
}

module "api_server" {
  source        = "./modules/ec2-instance"
  ami_id        = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"
  #   subnet_id          = aws_subnet.public.id
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-api"
  tags               = local.common_tags
}













# # VPC
# # Creates an isolated network in AWS
# resource "aws_vpc" "vpc" {
#   cidr_block           = var.vpc_cidr
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = merge(local.common_tags, {
#     Name = "Terraweek-VPC"
#   })

# }

# # Public Subnet
# # Public subnet inside the VPC
# resource "aws_subnet" "public_subnet" {
#   vpc_id            = aws_vpc.vpc.id
#   cidr_block        = var.subnet_cidr
#   availability_zone = data.aws_availability_zones.available.names[0]

#   tags = merge(local.common_tags, {

#     Name = "Terraweek-Public-Subnet"
#   })

# }

# # Internet Gateway
# # Connects VPC to the internet
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc.id

#   tags = merge(local.common_tags, {
#     Name = "Terraweek-igw"
#   })

# }

# # Route Table
# # Routes traffic from subnet to IGW
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = merge(local.common_tags, {
#     Name = "Terraweek-Public-RT"
#   })

# }

# # Route Table Association
# # Links subnet to the route table
# resource "aws_route_table_association" "public_rt_assoc" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }