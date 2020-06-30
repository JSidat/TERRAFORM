resource "aws_vpc" "AprilDevOpsVPC" {
    cidr_block = var.cidr
    enable_dns_hostnames = var.dns_hostname

    tags = {
        Name = "AprilDevOpsVPC"
    }   
}

data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_subnet" "AprilDevOpsPubnetA" {
    cidr_block = var.public_cidr_A
    availability_zone = data.aws_availability_zones.available.names[0]
    vpc_id = aws_vpc.AprilDevOpsVPC.id

    tags = {
        Name = "AprilDevOpsPubnetA"
    }
}

resource "aws_subnet" "AprilDevOpsPubnetB" {
    cidr_block = var.public_cidr_B
    availability_zone = data.aws_availability_zones.available.names[1]
    vpc_id = aws_vpc.AprilDevOpsVPC.id

    tags = {
        Name = "AprilDevOpsPubnetB"
    }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.AprilDevOpsVPC.id

  tags = {
    Name = "VPC Internet Gateway"
  }

}

resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.AprilDevOpsVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "Route Table for VPC"
  }
}

resource "aws_route_table_association" "pub_subA_rta" {
  subnet_id      = aws_subnet.AprilDevOpsPubnetA.id
  route_table_id = aws_route_table.vpc_rt.id
}

resource "aws_route_table_association" "pub_subB_rta" {
  subnet_id      = aws_subnet.AprilDevOpsPubnetB.id
  route_table_id = aws_route_table.vpc_rt.id
}