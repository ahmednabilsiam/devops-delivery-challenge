
variable "name" {
  description = "Name prefix for EC2 resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where EC2 will run"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 Key Pair name"
  type        = string
}


variable "allowed_cidr" {
  description = "Your public IPv4 address in /32 CIDR notation"
  type        = string

  validation {
    condition = (
      can(cidrnetmask(var.allowed_cidr)) &&
      can(regex("/32$", var.allowed_cidr)) &&
      length(split(".", split("/", var.allowed_cidr)[0])) == 4
    )
    error_message = "Provide a single IPv4 address with /32, for example 203.0.113.10/32."
  }
}
