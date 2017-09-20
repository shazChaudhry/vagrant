provider "aws" {
  region = "eu-west-2"
  shared_credentials_file = "/home/root/.aws/credentials"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    label = "myVPC"
  }
}

resource "aws_subnet" "public_subnet_a" {
  availability_zone       = "eu-west-2a"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = "${aws_vpc.vpc.id}"

  tags {
    Name = "public_subnet_a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  availability_zone       = "eu-west-2b"
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = "${aws_vpc.vpc.id}"

  tags {
    Name = "private_subnet_b"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "public_routetable" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    label = "custom_route_table"
  }
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = "${aws_subnet.public_subnet_a.id}"
  route_table_id = "${aws_route_table.public_routetable.id}"
}
