resource "aws_cloudwatch_log_group" "flow" {
  name = join("-", [var.name, "flowlogs"])

  tags = {
    Name = join("-", [var.name, "flowlogs"])
  }
}

resource "aws_cloudwatch_log_group" "alert" {
  name = join("-", [var.name, "alertlogs"])

  tags = {
    Name = join("-", [var.name, "alertlogs"])
  }
}
