variable "name" {
  type        = string
  description = "prefix of each resources"
}

variable "vpc_cidr" {
  type        = string
  description = "vpc cidr"
}

variable "firewall_subnet_cidr" {
  type        = string
  description = "subnet cidr"
}

variable "public_subnet_cidr" {
  type        = string
  description = "subnet cidr"
}

variable "allowed_domains" {
  type        = list(string)
  description = "allowed domains"
}
