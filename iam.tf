# Назначение пользователю cmtr-dmg42ceb политики AdministratorAccess
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = "cmtr-dmg42ceb"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Группа (можно оставить пустой или использовать для других пользователей)
resource "aws_iam_group" "group" {
  name = "${var.project_tag}-iam-group"
}

# Кастомная IAM-политика на запись в указанный бакет
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

# Роль для EC2-инстанса (чтобы писать в S3)
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

# Привязка кастомной политики к роли
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

# Instance profile для EC2, с этой ролью
resource "aws_iam_instance_profile" "profile" {
  name = "${var.project_tag}-iam-instance-profile"
  role = aws_iam_role.role.name
  tags = {
    Project = var.project_tag
  }
}