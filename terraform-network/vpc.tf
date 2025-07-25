resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name      = "cmtr-dmg42ceb-01-vpc"
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "cmtr_dmg42ceb"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name      = "cmtr-dmg42ceb-01-igw"
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "cmtr_dmg42ceb"
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name      = "cmtr-dmg42ceb-01-subnet-public-${each.key}"
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "cmtr_dmg42ceb"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "cmtr-dmg42ceb-01-rt"
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "cmtr_dmg42ceb"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}
