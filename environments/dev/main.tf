module "network_firewall" {
  source                 = "../../modules/network-firewall"
  name                   = "network-firewall-test"
  vpc_cidr               = "10.1.1.0/24"
  firewall_subnet1a_cidr = "10.1.1.16/28"
  public_subnet1a_cidr   = "10.1.1.32/28"
  allowed_domains        = [".google.com", ".amazonaws.com"]
}

module "ec2" {
  source           = "../../modules/ec2"
  name             = "network-firewall-test"
  vpc_id           = module.network_firewall.vpc_id
  subnet_id        = module.network_firewall.public_subnet_id
  instance_profile = "terada-admin-role"
}
