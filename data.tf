data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-dmg42ceb-vpc"]
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Name"
    values = ["cmtr-dmg42ceb-public_subnet"]
  }
}

data "aws_security_group" "cmtr_sg" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "group-name"
    values = ["cmtr-dmg42ceb-sg"]
  }
}