provider "aws" {
  region  = "us-east-2"
  profile = "cicd"
}

locals {
  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
EOF
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
module "vpc" {
  source = "github.com/youse-seguradora/terraform-aws-vpc"

  name = var.vpc_name

  cidr = "10.120.0.0/16"

  azs                    = ["us-east-2a"]
  compute_public_subnets = ["10.120.2.0/24"]
}

data "aws_security_group" "default" {
  vpc_id = module.vpc.vpc_id
  name   = "default"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

module "ec2" {
  source = "../../"

  instance_count = 1

  name                        = var.ec2_name
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  associate_public_ip_address = true

  user_data_base64 = base64encode(local.user_data)

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]

  tags = {
    "Env"      = "Private"
    "Location" = "Secret"
  }
}

