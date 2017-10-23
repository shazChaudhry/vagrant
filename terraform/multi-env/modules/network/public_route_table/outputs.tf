
output "aws_route_table_id" {
  description = "The ID of the VPC"
  value       = "${aws_route_table.custom_routetable.id}"
}
