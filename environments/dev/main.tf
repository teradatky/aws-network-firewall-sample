module "network_firewall" {
  source               = "../../modules/network_firewall"
  name                 = "dev-nfw"
  env                  = "dev"
  vpc_cidr             = "10.1.1.0/24"
  firewall_subnet_cidr = "10.1.1.16/28"
  public_subnet_cidr   = "10.1.1.32/28"
  allowed_domains      = [".google.com", ".amazonaws.com"]
}

module "ec2" {
  source    = "../../modules/ec2"
  name      = "dev-nfw"
  env       = "dev"
  vpc_id    = module.network_firewall.vpc_id
  subnet_id = module.network_firewall.public_subnet_id
}
