terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my-bucket" {
  bucket = "afroz-test-bucket"
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "terra-key"
  public_key = file("~/.ssh/terra-key.pub")
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_sec_grp" {
  name        = "terra-sec-grp"
  vpc_id      = aws_default_vpc.default.id
  description = "this is Inbound and outbound rules for your instance Security group"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_sec_grp.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "all_traffic" {
  security_group_id = aws_security_group.my_sec_grp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "my-instance" {
  ami                    = "ami-0931307dcdc2a28c9"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_sec_grp.id]
  root_block_device {
    volume_size = "10"
    volume_type = "gp3"
  }
  tags = {
    Name = "TerraWeek-Modified"
  }
}