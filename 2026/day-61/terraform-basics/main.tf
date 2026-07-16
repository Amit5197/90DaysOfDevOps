# Terraform Block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Provider Block
provider "aws" {
  region = "us-east-1"
}

# Create S3 bucket
resource "aws_s3_bucket" "bucket" {

  bucket = "terraweek-amitpa-2026"

}

# Create Ec2
resource "aws_instance" "instance" {
  ami           = "ami-0cb5cf49019e79c51"
  instance_type = "t3.micro" # t2.micro is not available for me so iam taking t3.micro

  tags = {
    Name = "TerraWeek-Modified"
  }
}
