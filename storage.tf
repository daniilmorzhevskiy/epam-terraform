resource "aws_s3_bucket" "cmtr_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = var.project_tag
  }

  force_destroy = false
}

resource "aws_s3_bucket_public_access_block" "cmtr_bucket_block" {
  bucket = aws_s3_bucket.cmtr_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}