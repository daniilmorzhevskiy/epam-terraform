resource "aws_s3_bucket" "cmtr_bucket" {
  bucket = "cmtr-dmg42ceb-bucket-1753693219"

  tags = {
    Project = "cmtr-dmg42ceb"
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