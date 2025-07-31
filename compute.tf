resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [data.aws_security_group.selected.id]
  associate_public_ip_address = true

  tags = {
    Name      = "${var.project_id}-instance"
    Project   = var.project_id
    Terraform = "true"
  }
}