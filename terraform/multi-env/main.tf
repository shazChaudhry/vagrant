provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.aws_credentials}"
  profile                 = "default"
}

module "devops_network" {
    source = "./devops/"
}
