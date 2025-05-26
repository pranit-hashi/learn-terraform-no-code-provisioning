# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = "us-east-1"
}

provider "random" {}

data "aws_availability_zones" "available" {}

resource "random_pet" "random" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "${random_pet.random.id}-education"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_instance" "education_" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "${var.instance_name}-education"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${random_pet.random.id}-education_ec2_sg"
  description = "Allow SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change to your IP for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${random_pet.random.id}-education_ec2_sg"
  }
}

# resource "aws_db_subnet_group" "education" {
#   name       = "${random_pet.random.id}-education"
#   subnet_ids = module.vpc.public_subnets

#   tags = {
#     Name = "${random_pet.random.id} Education"
#   }
# }

# resource "aws_security_group" "rds" {
#   name   = "${random_pet.random.id}-education_rds"
#   vpc_id = module.vpc.vpc_id

#   ingress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["192.80.0.0/16"]
#   }

#   egress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${random_pet.random.id}-education_rds"
#   }
# }

# resource "aws_db_parameter_group" "education" {
#   name   = "${random_pet.random.id}-education"
#   family = "postgres15"

#   parameter {
#     name  = "log_connections"
#     value = "1"
#   }
# }

# resource "aws_db_instance" "education" {
#   identifier             = "${var.db_name}-${random_pet.random.id}"
#   instance_class         = "db.t3.micro"
#   allocated_storage      = 5
#   engine                 = "postgres"
#   engine_version         = "15.6"
#   username               = var.db_username
#   password               = var.db_password
#   db_subnet_group_name   = aws_db_subnet_group.education.name
#   vpc_security_group_ids = [aws_security_group.rds.id]
#   parameter_group_name   = aws_db_parameter_group.education.name
#   publicly_accessible    = true
#   skip_final_snapshot    = true
# }
