resource "aws_security_group" "main" {
  name        = join("-", [var.env, var.name, "sg"])
  description = "security group for EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow traffic from same security group"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = join("-", [var.env, var.name, "sg"])
  }
}
