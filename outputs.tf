# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.education_.public_ip
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.education_.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

# output "rds_hostname" {
#   description = "RDS instance hostname"
#   value       = aws_db_instance.education.address
# }

# output "rds_port" {
#   description = "RDS instance port"
#   value       = aws_db_instance.education.port
# }

# output "rds_username" {
#   description = "RDS instance root username"
#   value       = aws_db_instance.education.username
# }

