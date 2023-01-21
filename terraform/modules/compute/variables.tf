###### required ######
variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "instance_name" {
  description = "Name of ec2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Id of subnet"
  type        = string
}

variable "region" {
  description = "Region selected"
  type        = string
}

variable "key_pair_name" {
  description = "key pair name"
  type        = string
}

###### optional/defualt ######
variable "tags" {
  description = "neccecry tags for resources"
  type        = map(string)
  default     = {
    Owner           = "Daniel Yakov"
    bootcamp        = "17"
    expiration_date = "01-04-2023"
  }
}