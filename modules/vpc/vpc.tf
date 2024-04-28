variable "cidr_block" {
  type = string
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "My-VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block          = cidrsubnet(aws_vpc.main.cidr_block, 2, 1)
  availability_zone = data.aws_availability_zones.available[0].name

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block          = cidrsubnet(aws_vpc.main.cidr_block, 2, 2)
  availability_zone = data.aws_availability_zones.available[1].name

  tags = {
    Name = "Private-Subnet"
  }
}

