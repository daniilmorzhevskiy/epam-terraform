resource "aws_iam_group" "iam_group" {
  name = "cmtr-dmg42ceb-iam-group"
}

resource "aws_iam_policy" "iam_policy" {
  name        = "cmtr-dmg42ceb-iam-policy"
  description = "Policy for S3 write access to cmtr-dmg42ceb-bucket-1753714264"
  policy = templatefile("${path.module}/policy.json", {
    bucket = "cmtr-dmg42ceb-bucket-1753714264"
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