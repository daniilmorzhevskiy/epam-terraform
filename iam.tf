# IAM Group
resource "aws_iam_group" "group" {
  name = "${var.project_tag}-iam-group"
}

# IAM Policy
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

# IAM Role
resource "aws_iam_role" "role" {
  name = "${var.project_tag}-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Project = var.project_tag
  }
}

# Attach IAM Policy to Role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "profile" {
  name = "${var.project_tag}-iam-instance-profile"
  role = aws_iam_role.role.name
  tags = {
    Project = var.project_tag
  }
}
resource "aws_iam_group" "iam_group" {
  name = "cmtr-dmg42ceb-iam-group"
}

resource "aws_iam_policy" "iam_policy" {
  name        = "cmtr-dmg42ceb-iam-policy"
  description = "Policy for S3 write access to cmtr-dmg42ceb-bucket-1753714264"
  policy = templatefile("${path.module}/policy.json", {
    bucket_name = "cmtr-dmg42ceb-bucket-1753714264"
  })

  tags = {
    Project = "cmtr-dmg42ceb"
  }
}

resource "aws_iam_role" "iam_role" {
  name = "cmtr-dmg42ceb-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = "cmtr-dmg42ceb"
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "cmtr-dmg42ceb-iam-instance-profile"
  role = aws_iam_role.iam_role.name
}