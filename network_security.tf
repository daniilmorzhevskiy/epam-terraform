data "aws_instance" "public_instance" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private_instance" {
  instance_id = var.private_instance_id
}

# SSH Security Group
resource "aws_security_group" "ssh_sg" {
  name        = "cmtr-dmg42ceb-ssh-sg"
  description = "Allow SSH and ICMP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  tags = {
    Project = "cmtr-dmg42ceb"
  }
}

# Public HTTP Security Group
resource "aws_security_group" "public_http_sg" {
  name        = "cmtr-dmg42ceb-public-http-sg"
  description = "Allow HTTP and ICMP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  tags = {
    Project = "cmtr-dmg42ceb"
  }
}

# Private HTTP Security Group
resource "aws_security_group" "private_http_sg" {
  name        = "cmtr-dmg42ceb-private-http-sg"
  description = "Allow HTTP and ICMP from Public SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http_sg.id]
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.public_http_sg.id]
  }

  tags = {
    Project = "cmtr-dmg42ceb"
  }
}

# Attach SGs to Public Instance
resource "aws_network_interface_sg_attachment" "attach_public_ssh" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = data.aws_instance.public_instance.network_interface_id
}

resource "aws_network_interface_sg_attachment" "attach_public_http" {
  security_group_id    = aws_security_group.public_http_sg.id
  network_interface_id = data.aws_instance.public_instance.network_interface_id
}

# Attach SGs to Private Instance
resource "aws_network_interface_sg_attachment" "attach_private_ssh" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = data.aws_instance.private_instance.network_interface_id
}

resource "aws_network_interface_sg_attachment" "attach_private_http" {
  security_group_id    = aws_security_group.private_http_sg.id
  network_interface_id = data.aws_instance.private_instance.network_interface_id
}