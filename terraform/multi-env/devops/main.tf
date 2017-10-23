

module "devops_vpc" {
    source = "../modules/network/vpc/"

    vpc_cidr_block = "${var.vpc_cidr_block}"
    vpc_name      = "${var.vpc_name}"
    internet_gateway_name = "${var.internet_gateway_name}"
    DnsZoneName = "${var.DnsZoneName}"
}

module "devops_route_table" {
  source = "../modules/network/public_route_table/"

  vpc_id = "${module.devops_vpc.vpc_id}"
  cidr_block = "0.0.0.0/0"
  gateway_id = "${module.devops_vpc.igw_id}"
  Name = "Custom route table"
}

# module "devops_subnet_public" {
#     source = "../modules/network/subnet_public/"
#
#     custom_route_table_name = "${var.custom_route_table_name}"
# }

# TODO: State is not being saved in S3 and not getting any error either. Will need to investigate
# terraform {
#     backend "s3" {
#       bucket = "shaz.terraform"
#       key    = "devops/terraform.tfstate"
#       region = "eu-west-2"
#       encrypt = "ture"
#     }
# }
