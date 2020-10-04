resource "aws_vpc" "demo" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "${local.common_prefix}-vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = cidrsubnet(aws_vpc.demo.cidr_block, 8, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.common_prefix}-public-subnet-${data.aws_availability_zones.available.names[0]}"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = cidrsubnet(aws_vpc.demo.cidr_block, 8, 1)
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.common_prefix}-public-subnet-${data.aws_availability_zones.available.names[1]}"
  }
}

resource "aws_subnet" "public_3" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = cidrsubnet(aws_vpc.demo.cidr_block, 8, 2)
  availability_zone = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.common_prefix}-public-subnet-${data.aws_availability_zones.available.names[2]}"
  }
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "${local.common_prefix}-igw"
  }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.demo.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo.id
    }

    tags = {
        Name = "${local.common_prefix}-public-rt"
    }
}

resource "aws_route_table_association" "public_1" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_3" {
    subnet_id = aws_subnet.public_3.id
    route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "nated_1" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = cidrsubnet(aws_vpc.demo.cidr_block, 8, 3)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${local.common_prefix}-nated-subnet-${data.aws_availability_zones.available.names[0]}"
  }
}

resource "aws_subnet" "nated_2" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = cidrsubnet(aws_vpc.demo.cidr_block, 8, 4)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${local.common_prefix}-nated-subnet-${data.aws_availability_zones.available.names[1]}"
  }
}

resource "aws_subnet" "nated_3" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = cidrsubnet(aws_vpc.demo.cidr_block, 8, 5)
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "${local.common_prefix}-nated-subnet-${data.aws_availability_zones.available.names[2]}"
  }
}

resource "aws_eip" "nat_gw_eip_1" {
  vpc = true
}

resource "aws_eip" "nat_gw_eip_2" {
  vpc = true
}

resource "aws_eip" "nat_gw_eip_3" {
  vpc = true
}

resource "aws_nat_gateway" "gw_1" {
  allocation_id = aws_eip.nat_gw_eip_1.id
  subnet_id     = aws_subnet.public_1.id
}

resource "aws_nat_gateway" "gw_2" {
  allocation_id = aws_eip.nat_gw_eip_2.id
  subnet_id     = aws_subnet.public_2.id
}

resource "aws_nat_gateway" "gw_3" {
  allocation_id = aws_eip.nat_gw_eip_3.id
  subnet_id     = aws_subnet.public_3.id
}

resource "aws_route_table" "nated_1" {
    vpc_id = aws_vpc.demo.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw_1.id
    }

    tags = {
        Name = "${local.common_prefix}-nated-rt-1"
    }
}

resource "aws_route_table" "nated_2" {
    vpc_id = aws_vpc.demo.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw_2.id
    }

    tags = {
        Name = "${local.common_prefix}-nated-rt-2"
    }
}

resource "aws_route_table" "nated_3" {
    vpc_id = aws_vpc.demo.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw_3.id
    }

    tags = {
        Name = "${local.common_prefix}-nated-rt-3"
    }
}

resource "aws_route_table_association" "nated_1" {
    subnet_id = aws_subnet.nated_1.id
    route_table_id = aws_route_table.nated_1.id
}

resource "aws_route_table_association" "nated_2" {
    subnet_id = aws_subnet.nated_2.id
    route_table_id = aws_route_table.nated_2.id
}
