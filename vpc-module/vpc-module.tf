provider "aws" {
    region = "us-east-1"
}

module "vpc" {
  source = "./module"

vpc-cidr    = "10.0.0.0/16"
vpc-name    = "Wordpress"
environment = "Test"
}
