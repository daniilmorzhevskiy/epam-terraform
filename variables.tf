variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "cmtr-dmg42ceb-bucket-1753693219"
}

variable "project_tag" {
  description = "Project tag for all resources"
  type        = string
  default     = "cmtr-dmg42ceb"
}

variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}