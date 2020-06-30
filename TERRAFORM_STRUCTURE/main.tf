provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "C:/Users/Junaid/.aws/credentials"
}

module "aws_vpc" {
  source = "./VPC"
}

module "aws_sg" {
  source = "./SG"
  vpc_id = module.aws_vpc.vpc_1
}

module "ec2" {
  source                 = "./EC2"
  public_subnet_id       = module.aws_vpc.subnet_A_id
  vpc_security_group_ids = module.aws_sg.aws_sg_id
}



