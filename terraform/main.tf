# Specify the provider and access details

provider "aws" {
  region = "${var.aws_region}"
  access_key = "AKIAXYKJXRIDU7EPQJJL"
  secret_key = "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"
}


# Create a VPC to launch our instances into
resource "aws_vpc" "infra-vpc" {
  cidr_block = "${var.aws_vpc_cidr}"

  tags = {
    Name = "${var.vpc_name}"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.infra-vpc.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.infra-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create Subnets
#################################################################
resource "aws_subnet" "web-az1a-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "${var.web-az1a-subnet-cidr}"
  availability_zone	  = "${var.aws_region}${var.az_suffix_1}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-web-az1${var.az_suffix_1}-subnet"
  }
}

resource "aws_subnet" "web-az1b-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "${var.web-az1b-subnet-cidr}"
  availability_zone       = "${var.aws_region}${var.az_suffix_2}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-web-az1${var.az_suffix_2}-subnet"
  }
}

resource "aws_subnet" "app-az1a-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "${var.app-az1a-subnet-cidr}"
  availability_zone       = "${var.aws_region}${var.az_suffix_1}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-app-az1${var.az_suffix_1}-subnet"
  }
}

resource "aws_subnet" "app-az1b-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "${var.app-az1b-subnet-cidr}"
  availability_zone       = "${var.aws_region}${var.az_suffix_2}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.vpc_prefix}-app-az1${var.az_suffix_2}-subnet"
  }
}

# Nat gateway #1
resource "aws_eip" "nat_1" {
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = "${aws_eip.nat_1.id}"
  subnet_id = "${aws_subnet.web-az1a-subnet.id}"
  depends_on = ["aws_internet_gateway.default"]
}

resource "aws_route_table" "nat_gw_1" {
  vpc_id = "${aws_vpc.infra-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_1.id}"
  }

}

resource "aws_route_table_association" "app_1_subnet_to_nat_gw" {
  route_table_id = "${aws_route_table.nat_gw_1.id}"
  subnet_id      = "${aws_subnet.app-az1a-subnet.id}"
}

resource "aws_route_table_association" "app_2_subnet_to_nat_gw" {
  route_table_id = "${aws_route_table.nat_gw_1.id}"
  subnet_id      = "${aws_subnet.app-az1b-subnet.id}"
}

# Security Groups
##################################################################
resource "aws_default_security_group" "terraform-default" {
  vpc_id = "${aws_vpc.infra-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project}-${var.vpc_prefix}-default-sg" }
}


# AWS KEY PAIR
###################################################################
resource "aws_key_pair" "auth_key_pair" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

# EC2
###################################################################
module "nginx" {
 source = "./modules/ec2"
 service_name = "nginx"
 vpc_id = "${aws_vpc.infra-vpc.id}"
 subnet_id = "${aws_subnet.app-az1a-subnet.id}"
 sg_id = "0.0.0.0"
 private_key_path = "${var.private_key_path}"
 aws_instance_type = "${var.aws_instance_type}"
 ami_id = "${var.ami_id}"
 project = "${var.project}"
 vpc_prefix = "${var.vpc_prefix}"
 run_list = "${var.run_list_nginx}"
 key_name = "${aws_key_pair.auth_key_pair.id}"
 aws_region = "${var.aws_region}" 
 aws_amis = "${var.aws_amis}"
 vpc_name = "${var.vpc_name}"
 public_key = "${var.public_key}"
 #chef_key = "${var.chef_key}"
 #chef_user = "${var.chef_user}"
 #chef_environment = "${var.chef_environment}" 
 #chef_server_url = "${var.chef_server_url}"
 bastion_ip = "0.0.0.0"
}
