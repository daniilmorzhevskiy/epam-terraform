# provider "aws" {
#   region = "us-east-1"
# }

# data "aws_vpc" "target_vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["cmtr-dmg42ceb-vpc"]
#   }
# }

# data "aws_subnet_ids" "public_subnets" {
#   vpc_id = data.aws_vpc.target_vpc.id
# }

resource "aws_instance" "cmtr_instance" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.public_subnet.id
  key_name               = aws_key_pair.cmtr_keypair.key_name
  vpc_security_group_ids = [data.aws_security_group.cmtr_sg.id]

  tags = {
    Name    = "cmtr-dmg42ceb-ec2"
    Project = "epam-tf-lab"
    ID      = "cmtr-dmg42ceb"
  }
}

# resource "aws_security_group" "cmtr_sg" {
#   name        = "cmtr_dmg42ceb_sg"
#   description = "SSH Allowed"
#   vpc_id      = data.aws_vpc.target_vpc.id

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Project = "epam-tf-lab"
#     ID      = "cmtr-dmg42ceb"
#   }
# }