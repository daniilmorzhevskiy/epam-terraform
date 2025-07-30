variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "project_tag" {
  description = "Project tag for resource naming"
  type        = string
  default     = "cmtr-dmg42ceb"
}

variable "bucket_name" {
  description = "Pre-existing S3 bucket name"
  type        = string
  default     = "cmtr-dmg42ceb-bucket-1753893090"
}