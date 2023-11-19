# firewall
resource "aws_networkfirewall_firewall" "main" {
  name                = join("-", [var.env, var.name, "firewall"])
  firewall_policy_arn = aws_networkfirewall_firewall_policy.main.arn
  vpc_id              = aws_vpc.main.id
  subnet_mapping {
    subnet_id = aws_subnet.firewall.id
  }

  tags = {
    Name = join("-", [var.env, var.name, "firewall"])
  }
}

# firewall policy
resource "aws_networkfirewall_firewall_policy" "main" {
  name = join("-", [var.env, var.name, "policy"])

  firewall_policy {
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]
    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.main.arn
    }
  }

  tags = {
    Name = join("-", [var.env, var.name, "policy"])
  }
}

# rule group
resource "aws_networkfirewall_rule_group" "main" {
  capacity = 100
  name     = join("-", [var.env, var.name, "rule"])
  type     = "STATEFUL"
  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["HTTP_HOST", "TLS_SNI"]
        targets              = var.allowed_domains
      }
    }
  }

  tags = {
    Name = join("-", [var.env, var.name, "rule"])
  }
}

# logging to cloudwatch
resource "aws_networkfirewall_logging_configuration" "main" {
  firewall_arn = aws_networkfirewall_firewall.main.arn
  logging_configuration {

    # flowlogs
    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.flow.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "FLOW"
    }

    # alertlogs
    log_destination_config {
      log_destination = {
        logGroup = aws_cloudwatch_log_group.alert.name
      }
      log_destination_type = "CloudWatchLogs"
      log_type             = "ALERT"
    }

  }
}
