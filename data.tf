data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-dmg42ceb-vpc"]
  }
}

data "aws_subnet" "public_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Name"
    values = ["cmtr-dmg42ceb-pub-sub1"]
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