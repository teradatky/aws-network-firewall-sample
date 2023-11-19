variable "name" {
  type        = string
  description = "prefix of each resources"
}

variable "env" {
  type        = string
  description = "prefix of environment"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "subnet_id" {
  type        = string
  description = "subnet id"
}

variable "instance_type" {
  type        = string
  description = "instance type"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "key name"
  default     = null
}

variable "instance_profile" {
  type        = string
  description = "instance profile"
  default     = null
}
