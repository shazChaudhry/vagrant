variable "public_key_path" {
  description = "Enter the path to the SSH Public Key to add to AWS."
  default     = "/home/root/.ssh/id_rsa.pub"
}

variable "aws_region" {
  description = "AWS London region to launch servers"
  default     = "eu-west-2"
}

variable "aws_credentials" {
  default = "/home/root/.aws/credentials"
}
