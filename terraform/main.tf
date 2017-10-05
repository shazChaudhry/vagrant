provider "aws" {
  region                  = "${var.aws_region}"
  shared_credentials_file = "${var.aws_credentials}"
  profile                 = "default"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags {
    Name = "myVPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "Internet gateway"
  }
}

resource "aws_route_table" "custom_routetable" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "Custom route table"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true
  tags {
    Name = "Public subnet"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.custom_routetable.id}"
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  depends_on    = ["aws_internet_gateway.igw"]
  tags {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "private_routetable" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }
  tags {
    Name = "private route table"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2b"

  tags {
    Name = "Private subnet"
  }
}

resource "aws_route_table_association" "private_subnet" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_routetable.id}"
}
