terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
    }

    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    } 

    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  
  // change the state file storage place to s3
  backend "s3" {
    bucket = "daniel-makeitdynamic-36236"
    key    = "state/terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = var.region
}