terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
}

provider "aws" {
  # profile = "default" # trungadmin
  region = "ap-northeast-1"
}

variable "ec2name" {
  description = "This is name of ec2"
  type    = string
  default = "Ec2 name"
  validation {
    error_message = "the miniums length 4 digits"
    condition = length(var.ec2name) >= 4
  }
   validation {
    error_message = "prefix must be abc"
   # can function return boolean
    condition = can(regex("abc", var.ec2name))
  }

  # show on ui
  sensitive = false

}


variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "type of ec2 instance"
}
resource "aws_instance" "my_server" {
  ami           = "ami-01b32aa8589df6208"
  instance_type = var.instance_type

  tags = {
    Name = var.ec2name
  }
}