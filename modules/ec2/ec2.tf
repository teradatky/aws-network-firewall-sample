data "aws_ami" "main" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}

resource "aws_instance" "main" {
  ami                    = data.aws_ami.main.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.main.id]
  iam_instance_profile   = var.instance_profile

  root_block_device {
    volume_type = "gp3"
    volume_size = "8"
  }

  tags = {
    Name = join("-", [var.name, "ec2"])
  }

}
