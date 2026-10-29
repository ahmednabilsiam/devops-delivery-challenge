
variable "aws_region" {
  description = "AWS region for the dev environment"
  type        = string
}

variable "key_name" {
  description = "Existing EC2 Key Pair name in the selected region"
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


variable "subnet_id" {
  description = "Optional subnet ID in the default VPC"
  type        = string
  default     = ""
}


variable "instance_type" {
  description = "EC2 instance type for the server"
  type        = string
  default     = "m7i-flex.large"
}
