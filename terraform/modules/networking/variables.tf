variable "name_prefix" {
  type    = string
  default = "pokernowai"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.123.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.123.1.0/24", "10.123.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.123.3.0/24", "10.123.4.0/24"]
}

variable "intra_subnet_cidrs" {
  type    = list(string)
  default = ["10.123.5.0/24", "10.123.6.0/24"]
}
