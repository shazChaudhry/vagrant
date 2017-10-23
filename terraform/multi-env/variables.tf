variable "region" {
  description = "AWS London region to launch servers"
  default     = "eu-west-2"
}

variable "aws_credentials" {
  default = "~/.aws/credentials"
}
