variable "cidr_block" {
  default = "10.0.0.0/16"
  description = "Cidr block of the vpc."
}

variable "vpc_name" {
  default = "main_vpc"
}

variable "public_subnet" {
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "az" {
  default= ["eu-west-1a","eu-west-1b","eu-west-1c"]
}



provider "aws" {
  region = "eu-west-1"
}


resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "public_subnet" {
  count                      = "${length(var.public_subnet)}"
  vpc_id                     = "${aws_vpc.vpc.id}"
  cidr_block                 = "${element(var.public_subnet, count.index)}"
  availability_zone          = "${element(var.az, count.index)}"
  map_public_ip_on_launch    = true


  tags = {
    Name = "public_subnet"
  }
}


output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "public_subnet_cidr" {
  value = "${aws_subnet.public_subnet.0.cidr_block}"
}


output "public_subnet_vars" {
  value = "${var.public_subnet}"
}

output "public_subnet_vars_other" {
  value = "${var.public_subnet[0]}"
}

output "concat" {
  value = "${concat(aws_subnet.public_subnet.*.id, aws_subnet.public_subnet.*.cidr_block)}"
}
