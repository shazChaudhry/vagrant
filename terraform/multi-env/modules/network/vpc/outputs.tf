
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${aws_vpc.vpc.id}"
}

output "igw_id" {
  description = "The ID of the Internet gateway"
  value       = "${aws_internet_gateway.igw.id}"
}
