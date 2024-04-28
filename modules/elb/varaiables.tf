variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "instance_id" {
  type = string
}

variable "internal" {
  type = bool
  default = false
}

variable "health_check_type" {
  type = string
  default = "HTTP"
}

variable "cross_zone" {
  type = bool
  default = true
}
