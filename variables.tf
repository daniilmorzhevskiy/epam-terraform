variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "project_tag" {
  default     = "cmtr-dmg42ceb"
  description = "Project tag for resource naming"
}

variable "bucket_name" {
  default     = "cmtr-dmg42ceb-bucket-1753893090"
  description = "Pre-existing S3 bucket"
}