#---------------------------------------------------------------------
#                              VPC
#---------------------------------------------------------------------

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-igw"
  }
}

#---------------------------------------------------------------------
#                    Public Subnets and Route Table
#---------------------------------------------------------------------

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-rds-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.env}-public-rtb"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public_subnet[*].id)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

#---------------------------------------------------------------------
#                    Private Subnets and Route Table
#---------------------------------------------------------------------

resource "aws_subnet" "private_subnet_db" {
  count                   = length(var.private_subnet_cidrs_db)
  cidr_block              = element(var.private_subnet_cidrs_db, count.index)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.env}-private-rds-${count.index + 1}"
  }
}

resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-private-database-rtb"
  }
}

resource "aws_route_table_association" "private_db" {
  count          = length(aws_subnet.private_subnet_db[*].id)
  subnet_id      = element(aws_subnet.private_subnet_db[*].id, count.index)
  route_table_id = aws_route_table.private_db.id
}
