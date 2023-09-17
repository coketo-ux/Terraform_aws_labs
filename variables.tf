variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "azs_list" {
  type    = list(any)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

# Declare the data source
data "aws_availability_zones" "azs" {
  state = "available"
}

variable "vpc_cidr" {
  description = "CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = list(any)
  description = "List of public subnets"
  default     = ["10.0.20.0/24", "10.0.30.0/24", "10.0.40.0/24"]
}

variable "private_subnet" {
  type        = list(any)
  description = "List of private subnets"
  default     = ["10.0.50.0/24", "10.0.60.0/24", "10.0.70.0/24"]
}

variable "ami_redhat" {
  type = string
  description = "Ami for redhat"
  default = "ami-013d87f7217614e10"
}

variable "imagenes" {
  type = map(any)
  description = "Map of images"
  default = {
    redhat = "ami-013d87f7217614e10"
    ubuntu = "ami-0a313d6098716f372"
    windows = "ami-00c896faf296575ab"
  }
}
  



