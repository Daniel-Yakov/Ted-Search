module "network" {
    source = "./modules/network"

    vpc_name = "daniel-vpc-tedsearch-${terraform.workspace}"
    subnet_name = "daniel-public-sub-${terraform.workspace}"
}

module "ec2" {
  source = "./modules/compute"

  vpc_id = module.network.vpc_id
  subnet_id = module.network.subnet_id
  instance_name = "daniel-tedsearch-${terraform.workspace}"
  region = var.region
  key_pair_name = "daniel-terraform-key-${terraform.workspace}"
}

# Config the app ec2 instance
resource "null_resource" "deploy" {
  triggers = {
    instance_id = module.ec2.instance_id
  }

  depends_on = [ module.ec2 ]

  # connect to ec2 with ssh
  connection {
    type     = "ssh"
    host = module.ec2.public_ip
    user = "ubuntu"
    private_key = module.ec2.key
  }

  # Copy files to config and run app on remote ec2 
  provisioner "file" {
    source      = "./config"
    destination = "/home/ubuntu/config"
  }

  # Config remote ec2
  provisioner "remote-exec" {
    inline = [
      "bash /home/ubuntu/config/install_docker.sh",
      "sudo docker load -i ./config/tedsearchimg.tar",
      "sudo docker compose -f ./config/docker-compose.yml up -d"
    ]
  }
}