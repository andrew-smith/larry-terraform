
variable "compartment_id" {}

variable "ad_name" {}

variable "subnet_id" {}

variable "instance_name" {
  default = "larry"
}

variable ssh_keys {}

variable "shape" {
  default = "VM.Standard.A1.Flex"
}

variable "cpus" {
  default = 4
}

variable "ram" {
  default = 24
}

variable "hdd" {
  default = 50
}

variable "data_hdd" {
  default = 150
}