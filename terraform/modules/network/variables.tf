variable "project" {
  description = "Префикс для имен ресурсов"
  type        = string
}

variable "subnets" {
  description = "Подсети по зонам: ключ — зона доступности, значение — CIDR"
  type        = map(string)

}

variable "admin_cidrs" {
  description = "Адреса администратора в формате CIDR: доступ к SSH и API Kubernetes"
  type        = list(string)
}