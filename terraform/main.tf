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
    Name = "Main VPC"
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

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true
  tags {
    Name = "Public subnet"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.custom_routetable.id}"
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public.id}"
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
    Name = "Private route table"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2b"

  tags {
    Name = "Private subnet"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private_routetable.id}"
}

resource "aws_security_group" "WebServerSG" {
  name        = "WebServerSG"
  description = "Security group for public facing ELBs"
  vpc_id      = "${aws_vpc.vpc.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.private.cidr_block}"]
  }
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.private.cidr_block}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "WebServerSG"
  }
}

resource "aws_security_group" "DBServerSG" {
  name        = "DBServerSG"
  description = "Security group for backend servers and private ELBs"
  vpc_id      = "${aws_vpc.vpc.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.public.cidr_block}"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.public.cidr_block}"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "DBServerSG"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "deployer-key"
  public_key = "${file(var.public_key_path)}"
}
