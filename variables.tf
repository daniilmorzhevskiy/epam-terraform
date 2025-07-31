variable "ssh_key_name" {
  type        = string
  description = "Name of the SSH key pair"
  default     = "cmtr-dmg42ceb-keypair"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = "vpc-xxxxxxxxxxxxxxxxx"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
  default     = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
  default     = ["subnet-zzzzzzzz", "subnet-aaaaaaaa"]
}

variable "ec2_sg_id" {
  type        = string
  description = "Security group ID for EC2 SSH access"
  default     = "sg-xxxxxxxxxxxxxxxxx"
}

variable "http_sg_id" {
  type        = string
  description = "Security group ID for HTTP access to instances"
  default     = "sg-yyyyyyyyyyyyyyyyy"
}

variable "lb_sg_id" {
  type        = string
  description = "Security group ID for ALB"
  default     = "sg-zzzzzzzzzzzzzzzzz"
}

variable "iam_instance_profile" {
  type        = string
  description = "Name of the IAM instance profile"
  default     = "cmtr-dmg42ceb-instance_profile"
}