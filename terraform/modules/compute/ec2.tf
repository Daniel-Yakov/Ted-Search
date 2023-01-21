locals {
  ec2_ami = {
    eu-west-3 = "ami-03c476a1ca8e3ebdc" # Paris
    eu-west-2 = "ami-0d09654d0a20d3ae2" # London
    eu-central-1 = "ami-03e08697c325f02ab" #Frankfurt
  }
}

# Create the app ec2 instance
resource "aws_instance" "app" {
    ami = local.ec2_ami[var.region]
    instance_type = "t3a.micro"
    key_name = aws_key_pair.key_pair.key_name
    subnet_id = var.subnet_id
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.sg.id ]

    tags = merge(var.tags, {
      Name = var.instance_name
    })
    
    lifecycle {
      create_before_destroy = true
    }
}

# The instance security group
resource "aws_security_group" "sg" {
    name = "daniel-tedsearch-sg"
    description = "tedsearch-sg"
    vpc_id = var.vpc_id

    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 22
      to_port = 22
      protocol = "tcp"
    } 

    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 80
      to_port = 80
      protocol = "tcp"
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

# create the ssh key
resource "tls_private_key" "gen_ssh_key" {
  algorithm = "RSA"
}

# create the key pair in aws
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.gen_ssh_key.public_key_openssh
}