# TerraformChallenge

# Terraform Coding Challenge

Challenge: Deploy a Highly Available Web Application Architecture on AWS

## Challenge

## Objective:

We are providing a Terraform script to deploy a simple, highly available web application architecture on AWS. The architecture includes the following components:

1. VPC with at least two public subnets in different Availability Zones (AZs) to ensure high availability.
2. EC2 Instances, distributed across the two public subnets.


## Architecture Diagram
Create an architecture Diagram like the folowing, showing your solution
![Example Diagram](diagram.png)

## Deliverable:

We want the candida to be able to
* Make recommendations / best practices
* Find any problem in the TF code and fix it
* Create a VPC/Networking working module
* Execute the TF plan

## Instructions:
* We will share this repository live with the candidate
* After reviewing the code, and executing the plan (with no errors) we will ask the candidate to take control and start working in the requests with minimal input from our side

TF init
<summary>terraform init</summary>

<details>
 terraform init

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.41.0

╷
│ Warning: Quoted references are deprecated
│
│   on main.tf line 83, in resource "aws_nat_gateway" "nat_1":
│   83:   depends_on = ["aws_internet_gateway.default"]
│
│ In this context, references are expected literally rather than in quotes.
│ Terraform 0.11 and earlier required quotes, but quoted references are now
│ deprecated and will be removed in a future version of Terraform. Remove the
│ quotes surrounding this reference to silence this warning.
│
│ (and 2 more similar warnings elsewhere)
╵

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
</details>


<summary>terraform plan</summary>

<details>
terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_default_security_group.terraform-default will be created
  + resource "aws_default_security_group" "terraform-default" {
      + arn                    = (known after apply)
      + description            = (known after apply)
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = (known after apply)
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "demo-infra-default-sg"
        }
      + tags_all               = {
          + "Name" = "demo-infra-default-sg"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_eip.nat_1 will be created
  + resource "aws_eip" "nat_1" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = (known after apply)
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags_all             = (known after apply)
      + vpc                  = (known after apply)
    }

  # aws_internet_gateway.default will be created
  + resource "aws_internet_gateway" "default" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags_all = (known after apply)
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.auth_key_pair will be created
  + resource "aws_key_pair" "auth_key_pair" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "my-east-1"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCohXWgFUTuzH1Jmbo+TB+b85kR/7D/0Lvx/m38hNUGPfJRZCvdkAALOgfVnAWt66Q7V1VJ7q9VJhwiDgVjI08qE6FBdOk1mrvyXaqo00zHIRjpZGKcMHZgzDx6n/r89IUKSOr7/ATHNY98xpARB5RKgHyspQlmXzC+tJcRLDzLnTh2Zmu7GQSU+BLmIpTv3/9pzItbgFREw6xhxCg31E+FTGuDDPzW5SXCYiWS8u9XBbmx/asdnU/r0OuOvLeA5gX7YBU/PdCxO8uCoC6C4Fk2t3a6caG60NYuHYUDF5Ou83DHy+m74K2rPFYSbmMWdwiNhjIngUmsMwffBFQu0puX my-east1"
      + tags_all        = (known after apply)
    }

  # aws_nat_gateway.nat_1 will be created
  + resource "aws_nat_gateway" "nat_1" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags_all                           = (known after apply)
    }

  # aws_route.internet_access will be created
  + resource "aws_route" "internet_access" {
      + destination_cidr_block = "0.0.0.0/0"
      + gateway_id             = (known after apply)
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + route_table_id         = (known after apply)
      + state                  = (known after apply)
    }

  # aws_route_table.nat_gw_1 will be created
  + resource "aws_route_table" "nat_gw_1" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = (known after apply)
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.app_1_subnet_to_nat_gw will be created
  + resource "aws_route_table_association" "app_1_subnet_to_nat_gw" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.app_2_subnet_to_nat_gw will be created
  + resource "aws_route_table_association" "app_2_subnet_to_nat_gw" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_subnet.app-az1a-subnet will be created
  + resource "aws_subnet" "app-az1a-subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.200.0.64/27"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "demo-infra-app-az1a-subnet"
        }
      + tags_all                                       = {
          + "Name" = "demo-infra-app-az1a-subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.app-az1b-subnet will be created
  + resource "aws_subnet" "app-az1b-subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.200.0.96/27"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "demo-infra-app-az1b-subnet"
        }
      + tags_all                                       = {
          + "Name" = "demo-infra-app-az1b-subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.web-az1a-subnet will be created
  + resource "aws_subnet" "web-az1a-subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.200.0.0/27"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "demo-infra-web-az1a-subnet"
        }
      + tags_all                                       = {
          + "Name" = "demo-infra-web-az1a-subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.web-az1b-subnet will be created
  + resource "aws_subnet" "web-az1b-subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.200.0.32/27"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "demo-infra-web-az1b-subnet"
        }
      + tags_all                                       = {
          + "Name" = "demo-infra-web-az1b-subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.infra-vpc will be created
  + resource "aws_vpc" "infra-vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.200.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = (known after apply)
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "infra-vpc"
        }
      + tags_all                             = {
          + "Name" = "infra-vpc"
        }
    }

  # module.nginx.aws_instance.ec2 will be created
  + resource "aws_instance" "ec2" {
      + ami                                  = "ami-c998b6b2"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = false
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "demo-infra-nginx"
        }
      + tags_all                             = {
          + "Name" = "demo-infra-nginx"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + ebs_block_device {
          + delete_on_termination = true
          + device_name           = "/dev/sdb"
          + encrypted             = true
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags_all              = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 50
          + volume_type           = "gp2"
        }
    }

  # module.nginx.aws_security_group.ec2-sg will be created
  + resource "aws_security_group" "ec2-sg" {
      + arn                    = (known after apply)
      + description            = "nginx security group"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = true
              + to_port          = 0
            },
        ]
      + name                   = "nginx-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "demo-infra-nginx-sg"
        }
      + tags_all               = {
          + "Name" = "demo-infra-nginx-sg"
        }
      + vpc_id                 = (known after apply)
    }

Plan: 16 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + nginx_ip          = (known after apply)
  + public_ip         = (known after apply)
  + security_group_id = (known after apply)
  + subnet_id         = (known after apply)
  + vpc_id            = (known after apply)
╷
│ Warning: Quoted references are deprecated
│
│   on main.tf line 83, in resource "aws_nat_gateway" "nat_1":
│   83:   depends_on = ["aws_internet_gateway.default"]
│
│ In this context, references are expected literally rather than in quotes.
│ Terraform 0.11 and earlier required quotes, but quoted references are now
│ deprecated and will be removed in a future version of Terraform. Remove the
│ quotes surrounding this reference to silence this warning.
</details>


* Next, we will request the candidate to submit new code, with main focus on creating the vpc/networking module. ALso he can propose other ideas like
* * Add an new resource (ec2, etc)
* * Output a value from one resource to another (example> name)
* * Create an ASG from the instances
* * Create a module for the ASG
* The current code is set up as a example, but is not is an "ideal/best pracices"  state. We will fix it or create our own as needed.
* The candidate plan should be focus on the vpc/networking module, adding at least the same amount of resources (16)
Plan: 16 to add, 0 to change, 0 to destroy.

* Focus on best practices.

