variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "project_tag" {
  description = "Project tag for all resources"
  type        = string
  default     = "cmtr-dmg42ceb"
}