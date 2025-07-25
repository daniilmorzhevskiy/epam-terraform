variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets with AZ and CIDR"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}
