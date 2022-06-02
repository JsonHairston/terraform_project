variable "region" {
  type = string
  default = "us-east-1"
}

variable "azs" {
  description = "Availability zones"
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  description = "CIDR range of VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type = string
  default     = "terraform_vpc"
}

variable "private_subnets" {
  description = "private subnets CIDR range"
  type = string
  default = "10.0.3.0/24"
}

variable "public_subnets" {
  description = "public subnets CIDR range"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}


variable "lb_name" {
    description = "Name of load balancer"
    type = string
    default = "terraform_lb"
}
