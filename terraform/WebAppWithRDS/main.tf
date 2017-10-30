provider "aws" {
  region                           = "${var.region}"
  shared_credentials_file          = "${var.aws_credentials}"
  profile                          = "default"
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    azs                           = ["eu-west-2a", "eu-west-2b"]    # A list of availability zones in the region
    cidr                          = "10.0.0.0/16"                   # The CIDR block for the VPC
    enable_dns_hostnames          = true                            # Should be true if you want to use private DNS within the VPC
    enable_dns_support            = true                            # Should be true if you want to use private DNS within the VPC
    enable_nat_gateway            = true                            # Should be true if you want to provision NAT Gateways for each of your private networks
    map_public_ip_on_launch       = true                            # Should be false if you do not want to auto-assign public IP on launch
    name                          = "ci-vpc"                        # Name to be used on all the resources as identifier
    private_subnets               = ["10.0.1.0/24", "10.0.2.0/24"]  # A list of private subnets inside the VPC
    public_subnets                = ["10.0.0.0/24"]                 # A list of public subnets inside the VPC
    single_nat_gateway            = true                            # Should be true if you want to provision a single shared NAT Gateway across all of your private networks
    tags = {                                                        # A map of tags to add to all resources
      Owner                       = "DevOps"
      Environment                 = "CI"
    }
}

module "WebApp_sg" {
    source = "terraform-aws-modules/security-group/aws"

    name                          = "WebApp_sg"
    description                   = "Security Group for WebApp"
    vpc_id                        = "${module.vpc.vpc_id}"
    ingress_cidr_blocks           = ["0.0.0.0/0"]
    ingress_rules                 = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
    egress_cidr_blocks            = ["0.0.0.0/0"]
    egress_rules                  = ["all-all"]
    tags = {
      Owner                       = "DevOps"
      Environment                 = "CI"
    }
}

module "DB_sg" {
    source = "terraform-aws-modules/security-group/aws"

    name                          = "WebApp_db_sg"
    description                   = "Security Group for MySQL"
    vpc_id                        = "${module.vpc.vpc_id}"
    ingress_cidr_blocks           = ["10.0.0.0/24"]
    ingress_rules                 = ["mysql-tcp", "ssh-tcp"]
    egress_cidr_blocks            = ["0.0.0.0/0"]
    egress_rules                  = ["all-all"]
    tags = {
      Owner                       = "DevOps"
      Environment                 = "CI"
    }
}

module "rds" {
    source = "terraform-aws-modules/rds/aws"

    allocated_storage             = 20
    backup_window                 = "03:00-06:00"
    engine                        = "mysql"
    engine_version                = "5.7.11"
    identifier                    = "webappdb-instance"
    instance_class                = "db.t2.micro"
    maintenance_window            = "Mon:00:00-Mon:03:00"
    name                          = "WebAppDB"
    password                      = "YourPwdShouldBeLongAndSecure!"
    port                          = "3306"
    username                      = "user"
    family                        = "mysql5.7"
    parameters = [
      {
        name = "character_set_client"
        value = "utf8"
      },
      {
        name = "character_set_server"
        value = "utf8"
      }
    ]
    subnet_ids                    = ["${module.vpc.private_subnets}"]
    tags = {
      Owner                       = "DevOps"
      Environment                 = "CI"
    }
    vpc_security_group_ids        = ["${module.DB_sg.this_security_group_id}"]
}

module "ec2-instance" {
    source = "terraform-aws-modules/ec2-instance/aws"

    ami                           = "ami-f1949e95"
    instance_type                 = "t2.micro"
    name                          = "WebApp"
    vpc_security_group_ids        = ["${module.WebApp_sg.this_security_group_id}"]
    availability_zone             = "eu-west-2a"
    key_name                      = "personal"
    subnet_id                     = "${module.vpc.public_subnets[0]}"
    tags = {
      Owner                       = "DevOps"
      Environment                 = "CI"
    }
    volume_tags = {
      Owner                       = "DevOps"
      Environment                 = "CI"
    }
}

# https://registry.terraform.io/modules/KoeSystems/route53/aws/0.1.1
# Terraform AWS Route53 module to create public hosted zones
module "route53" {
    source = "KoeSystems/route53/aws"
    domain_name    = "${var.DnsZoneName}"
}

# Terraform Cluster Domain (e.g. `prod.ourcompany.com`)
# module "route53-cluster-zone" {
#     source = "cloudposse/route53-cluster-zone/aws"
#
#     # insert the 3 required variables here
# }

# https://registry.terraform.io/modules/cloudposse/route53-cluster-hostname/aws/0.1.1
# Terraform Module to define a consistent cluster hostname
module "webappdb" {
    source      = "cloudposse/route53-cluster-hostname/aws"
    zone_id     = "${module.route53.primary_public_zone_id}"
    name        = "webappdb"
    records     = ["${module.rds.this_db_instance_address}"]
}

module "webapp" {
    source      = "cloudposse/route53-cluster-hostname/aws"
    zone_id     = "${module.route53.primary_public_zone_id}"
    name        = "webapp"
    records     = ["${module.ec2-instance.public_ip}"]
}
