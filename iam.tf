resource "aws_iam_policy" "policy" {
  name        = "${var.project_tag}-iam-policy"
  description = "Write-only access to the S3 bucket"
  policy = templatefile("${path.module}/policy.json", {
    bucket_name = var.bucket_name
  })
  tags = {
    Project = var.project_tag
  }
}