
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "server" {
  source = "../../modules/ec2"

  name          = "devops-delivery-server"
  vpc_id        = data.aws_vpc.default.id
  subnet_id     = var.subnet_id != "" ? var.subnet_id : data.aws_subnets.default.ids[0]
  instance_type = var.instance_type
  key_name      = var.key_name
  allowed_cidr  = var.allowed_cidr
}
