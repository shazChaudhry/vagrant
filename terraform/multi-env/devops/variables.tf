variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "VPC address range"
}

variable "vpc_name" {
  default = "DevOps_VPC"
  description = "VPC tag"
}

variable "internet_gateway_name" {
  default = "DevOps_igw"
  description = "Internet gateway name"
}

variable "custom_route_table_name" {
  default = "DevOps_custom_rt"
  description = "Custom route table"
}

variable "DnsZoneName" {
  default     = "devops.internal"
  description = "the internal dns name"
}
