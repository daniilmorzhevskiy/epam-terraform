resource "aws_instance" "web" {
  ami                    = "ami-0fc5d935ebf8bc3bc" # Amazon Linux 2023 AMI (us-east-1)
  instance_type          = "t3.micro"
  subnet_id              = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  tags = {
    Name      = "cmtr-dmg42ceb-ec2"
    Terraform = "true"
    Project   = var.project_id
  }
}