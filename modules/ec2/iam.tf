data "aws_iam_policy_document" "trust_ec2" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance" {
  name                = join("-", [var.env, var.name, "ec2-role"])
  description         = "Allow EC2 to connect SSM"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  assume_role_policy  = data.aws_iam_policy_document.trust_ec2.json
}

resource "aws_iam_instance_profile" "instance" {
  name = join("-", [var.env, var.name, "ec2-role"])
  role = aws_iam_role.instance.name
}
