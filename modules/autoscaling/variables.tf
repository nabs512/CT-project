variable "vpc_id" {
  type = string
}

variable "launch_configuration_name" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "min_size" {
  type = number
  default = 1
}

variable "max_size" {
  type = number
  default = 2
}