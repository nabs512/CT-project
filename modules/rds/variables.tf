variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "engine" {
  type = string
  default = "mysql"
}

variable "engine_version" {
  type = string
  default = "8.0"
}

variable "instance_class" {
  type = string
  default = "db.t2.micro"
}

variable "allocated_storage" {
  type = number
  default = 20
}

variable "multi_az" {
  type = bool
  default = true
}