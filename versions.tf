terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.0.0"
    }
  }
}

variable "region" {
  type = string
  default = "us-east-1"
}
