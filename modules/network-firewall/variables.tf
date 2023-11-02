variable "name" {
  type        = string
  description = "prefix of each resources"
  default     = "network-firewall-sample"
}

variable "vpc_cidr" {
  type        = string
  description = "vpc cidr"
  default     = ""
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "subnet 1a and 1c cidr"
  default     = ["value"]
}

variable "allowed_domains" {
  type        = list(string)
  description = "allowed domains"
  default     = ["value"]
}
