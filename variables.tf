# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  # default     = "my-ec2-instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  # default     = "t3.micro"
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  # default     = "ami-0953476d60561c955" # Example for us-east-1
}

# variable "db_name" {
#   description = "Unique name to assign to RDS instance"
# }

# variable "db_username" {
#   description = "RDS root username"
# }

# variable "db_password" {
#   description = "RDS root user password"
#   sensitive   = true
# }