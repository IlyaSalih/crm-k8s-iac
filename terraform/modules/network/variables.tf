variable "project" {
  description = "Префикс для имен ресурсов"
  type        = string
}

variable "zone" {
  description = "Зона доступности подсети"
  type        = string
}

variable "subnet_cidr" {
  description = "Диапазон IP адресов подсети"
  type        = string
}