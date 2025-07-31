# variable "aws_region" {
#   description = "The AWS region to deploy resources in"
#   type        = string
#   default     = "us-east-1"
# }

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.3.0/24", "10.10.5.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "project_id" {
  description = "Project ID for naming"
  type        = string
  default     = "cmtr-dmg42ceb-01"
}