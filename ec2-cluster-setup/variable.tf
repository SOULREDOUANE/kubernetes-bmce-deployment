variable "access_key" { #Todo: uncomment the default value and add your access key.
  description = "Access key to AWS console"
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "secret_key" {  #Todo: uncomment the default value and add your secert key.
  description = "Secret key to AWS console"
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "ami_key_pair_name" { #Todo: uncomment the default value and add your pem key pair name. Hint: don't write '.pem' exction just the key name
  default = "main-key"
}


# Region to build in
variable "aws_region" {
  type    = string
  default = "eu-west-3"
}


# Names of the EC2 instances to create
locals {
  instances = [
    "controlplane",
    "node01",
    "node02"
  ]
}
