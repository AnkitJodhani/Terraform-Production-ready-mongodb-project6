#------------------------------------------------------ VPC -----------------------------------------------------------------------

# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}


# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

#------------------------------------------------------ Public subnet----------------------------------------------------------------

# create public subnet pub-sub-1-a
resource "aws_subnet" "pub-sub-1-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUB_SUB_1_A_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "pub-sub-1-a"
  }
}

# create public subnet pub-sub-2-b
resource "aws_subnet" "pub-sub-2-b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUB_SUB_2_B_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "pub-sub-2-b"
  }
}
# create public subnet pub-sub-3-c
resource "aws_subnet" "pub-sub-3-c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUB_SUB_3_C_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "pub-sub-3-c"
  }
}

#------------------------------------------------------ Private subnet----------------------------------------------------------------

# create private app pri-sub-4-a
resource "aws_subnet" "pri-sub-4-a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.PRI_SUB_4_A_CIDR
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-4-a"
  }
}
# create private app pri-sub-5-b
resource "aws_subnet" "pri-sub-5-b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.PRI_SUB_5_B_CIDR
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-5-b"
  }
}
# create private app pri-sub-6-c
resource "aws_subnet" "pri-sub-6-c" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.PRI_SUB_6_C_CIDR
  availability_zone        = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-6-c"
  }
}
# create private app pri-sub-7-a
resource "aws_subnet" "pri-sub-7-a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.PRI_SUB_7_A_CIDR
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-7-a"
  }
}
# create private app pri-sub-8-b
resource "aws_subnet" "pri-sub-8-b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.PRI_SUB_8_B_CIDR
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-8-b"
  }
}
# create private app pri-sub-9-c
resource "aws_subnet" "pri-sub-9-c" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.PRI_SUB_9_C_CIDR
  availability_zone        = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "pri-sub-9-c"
  }
}

#------------------------------------------------------ IGW -----------------------------------------------------------------------

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "${var.PROJECT_NAME}-igw"
  }
}


#------------------------------------------------------ Public-RT & subnet association -----------------------------------------------------------------------

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "Public-RT"
  }
}


# associate public subnet pub-sub-1-a to "public route table"
resource "aws_route_table_association" "pub-sub-1-a_route_table_association" {
  subnet_id           = aws_subnet.pub-sub-1-a.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "pub-sub-2-b_route_table_association" {
  subnet_id           = aws_subnet.pub-sub-2-b.id
  route_table_id      = aws_route_table.public_route_table.id
}
# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "pub-sub-3-c_route_table_association" {
  subnet_id           = aws_subnet.pub-sub-3-c.id
  route_table_id      = aws_route_table.public_route_table.id
}


#------------------------------------------------------ 3 Elastic IP for 3 NAT-GW -----------------------------------------------------------------------

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-1-a
resource "aws_eip" "EIP-NAT-GW-A" {
  vpc    = true

  tags   = {
    Name = "NAT-GW-EIP-A"
  }
}
# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-2-b
resource "aws_eip" "EIP-NAT-GW-B" {
  vpc    = true

  tags   = {
    Name = "NAT-GW-EIP-B"
  }
}
# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-3-c
resource "aws_eip" "EIP-NAT-GW-C" {
  vpc    = true

  tags   = {
    Name = "NAT-GW-EIP-C"
  }
}

#------------------------------------------------------ NAT-GW -----------------------------------------------------------------------

# create nat gateway in public subnet pub-sub-1-a
resource "aws_nat_gateway" "NAT-GW-A" {
  allocation_id = aws_eip.EIP-NAT-GW-A.id
  subnet_id     = aws_subnet.pub-sub-1-a.id

  tags   = {
    Name = "NAT-GW-A"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [aws_vpc.vpc]
}
# create nat gateway in public subnet pub-sub-2-b
resource "aws_nat_gateway" "NAT-GW-B" {
  allocation_id = aws_eip.EIP-NAT-GW-B.id
  subnet_id     = aws_subnet.pub-sub-2-b.id

  tags   = {
    Name = "NAT-GW-B"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [aws_vpc.vpc]
}
# create nat gateway in public subnet pub-sub-3-c
resource "aws_nat_gateway" "NAT-GW-C" {
  allocation_id = aws_eip.EIP-NAT-GW-C.id
  subnet_id     = aws_subnet.pub-sub-3-c.id

  tags   = {
    Name = "NAT-GW-C"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [aws_vpc.vpc]
}

#------------------------------------------------------ Private RTs  -----------------------------------------------------------------------

# create private route table Pri-RT-A and add route through NAT-GW-A
resource "aws_route_table" "Pri-RT-A" {
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.NAT-GW-A.id
  }

  tags   = {
    Name = "Pri-RT-A"
  }
}
# create private route table Pri-RT-B and add route through NAT-GW-B
resource "aws_route_table" "Pri-RT-B" {
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.NAT-GW-B.id
  }

  tags   = {
    Name = "Pri-RT-B"
  }
}
# create private route table Pri-RT-C and add route through NAT-GW-C
resource "aws_route_table" "Pri-RT-C" {
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.NAT-GW-C.id
  }

  tags   = {
    Name = "Pri-RT-C"
  }
}


#------------------------------------------------------ Private subnet association  -----------------------------------------------------------------------

# associate private subnet pri-sub-4-a with private route table Pri-RT-A
resource "aws_route_table_association" "pri-sub-4-a-with-Pri-RT-A" {
  subnet_id         = aws_subnet.pri-sub-4-a.id
  route_table_id    = aws_route_table.Pri-RT-A.id
}
# associate private subnet pri-sub-7-a with private route table Pri-RT-A
resource "aws_route_table_association" "pri-sub-7-a-with-Pri-RT-A" {
  subnet_id         = aws_subnet.pri-sub-7-a.id
  route_table_id    = aws_route_table.Pri-RT-A.id
}

# associate private subnet pri-sub-5-b with private route table Pri-RT-B
resource "aws_route_table_association" "pri-sub-5-b-with-Pri-RT-B" {
  subnet_id         = aws_subnet.pri-sub-5-b.id
  route_table_id    = aws_route_table.Pri-RT-B.id
}
# associate private subnet pri-sub-8-b with private route table Pri-RT-B
resource "aws_route_table_association" "pri-sub-8-b-with-Pri-RT-B" {
  subnet_id         = aws_subnet.pri-sub-8-b.id
  route_table_id    = aws_route_table.Pri-RT-B.id
}

# associate private subnet pri-sub-6-c with private route table Pri-RT-C
resource "aws_route_table_association" "pri-sub-6-c-with-Pri-RT-C" {
  subnet_id         = aws_subnet.pri-sub-6-c.id
  route_table_id    = aws_route_table.Pri-RT-C.id
}
# associate private subnet pri-sub-9-c with private route table Pri-RT-C
resource "aws_route_table_association" "pri-sub-9-c-with-Pri-RT-C" {
  subnet_id         = aws_subnet.pri-sub-9-c.id
  route_table_id    = aws_route_table.Pri-RT-C.id
}

