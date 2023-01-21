###### required ######
# vpc.tf vars
variable "vpc_name" {
  description = "The name of the vpc"
  type = string
}

# subnet.tf vars
variable "subnet_name" {
  description = "Name of subnet"
  type        = string
}

###### optional/defualt ######
# global
variable "tags" {
  description = "neccecry tags for resources"
  type        = map(string)
  default     = {
    Owner           = "Daniel Yakov"
    bootcamp        = "17"
    expiration_date = "01-04-2023"
  }
}

# vpc.tf vars
variable "vpc_cidr_block" {
  description = "VPC's cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

# subnet.tf vars
variable "subnet_cidr_block" {
  description = "Subnet's cidr block"
  type        = string
  default     = "10.0.1.0/24"
}

