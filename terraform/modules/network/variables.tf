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

variable "admin_cidrs" {
  description = "Адреса администратора в формате CIDR: доступ к SSH и API Kubernetes"
  type        = list(string)
}