# main vpc
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = join("-", [var.env, var.name, "vpc"])
  }
}

# firewall subnet
resource "aws_subnet" "firewall" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.firewall_subnet_cidr
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = join("-", [var.env, var.name, "firewall-subnet-1a"])
  }
}

# public subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = join("-", [var.env, var.name, "public-subnet-1a"])
  }
}

# internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = join("-", [var.env, var.name, "igw"])
  }
}

# we don't need specify local routing
# because AWS automatically create a local routing rule

# main route tale
resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.main_route_table_id

  tags = {
    Name = join("-", [var.env, var.name, "main-rtb"])
  }
}

# ingress routing
resource "aws_route_table" "ingress" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = var.public_subnet_cidr
    vpc_endpoint_id = tolist(aws_networkfirewall_firewall.main.firewall_status[0].sync_states)[0].attachment[0].endpoint_id
  }

  tags = {
    Name = join("-", [var.env, var.name, "ingress-rtb"])
  }
}

# firewall routing
resource "aws_route_table" "firewall" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = join("-", [var.env, var.name, "firewall-rtb"])
  }
}

# public routing
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    vpc_endpoint_id = tolist(aws_networkfirewall_firewall.main.firewall_status[0].sync_states)[0].attachment[0].endpoint_id
  }

  tags = {
    Name = join("-", [var.env, var.name, "public-rtb"])
  }
}

# route table association of ingress routing
resource "aws_route_table_association" "ingress" {
  gateway_id     = aws_internet_gateway.main.id
  route_table_id = aws_route_table.ingress.id
}

# route table association of firewall subnet
resource "aws_route_table_association" "firewall" {
  subnet_id      = aws_subnet.firewall.id
  route_table_id = aws_route_table.firewall.id
}

# route table association of public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
