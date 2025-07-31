variable "project_id" {
  description = "Project identifier"
  type        = string
  default     = "cmtr-dmg42ceb"
}

variable "ssh_key_name" {
  description = "SSH Key pair name"
  type        = string
  default     = "cmtr-dmg42ceb-keypair"
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
  default     = ["subnet-XXXX", "subnet-YYYY"]
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
  default     = ["subnet-ZZZZ", "subnet-WWWW"]
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-XXXXX"
}

variable "ec2_sg_id" {
  description = "Security group ID for EC2 instances"
  type        = string
  default     = "sg-abc123"
}

variable "http_sg_id" {
  description = "Security group ID for HTTP"
  type        = string
  default     = "sg-def456"
}

variable "lb_sg_id" {
  description = "Security group ID for Load Balancer"
  type        = string
  default     = "sg-lb789"
}

variable "ami_id" {
  description = "AMI ID to use for EC2"
  type        = string
  default     = "ami-09e6f87a47903347c"
}