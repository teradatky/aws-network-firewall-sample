resource "aws_cloudwatch_log_group" "flow" {
  name = join("-", [var.env, var.name, "flowlogs"])

  tags = {
    Name = join("-", [var.env, var.name, "flowlogs"])
  }
}

resource "aws_cloudwatch_log_group" "alert" {
  name = join("-", [var.env, var.name, "alertlogs"])

  tags = {
    Name = join("-", [var.env, var.name, "alertlogs"])
  }
}
