variable "ami_id" {
  type    = string
  default = "ami-084568db4383264d4"
}

variable "inst_type" {
  type    = string
  default = "t2.medium"
}

variable "key_name" {
  type    = string
  default = "Hcl-prac-training"
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}



