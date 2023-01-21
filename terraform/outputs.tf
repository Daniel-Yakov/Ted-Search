output "network" {
  value = {
    vpc = module.network.vpc_id
    subnet = module.network.subnet_id
  }
}

output "ec2" {
  value = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}