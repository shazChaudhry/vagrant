
resource "aws_route_table" "custom_routetable" {
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "${var.Name}"
  }
}

resource "aws_route" "custom_routetable" {
  route_table_id = "${aws_route_table.custom_routetable.id}"
  destination_cidr_block = "${var.cidr_block}"
  gateway_id = "${var.gateway_id}"
}
