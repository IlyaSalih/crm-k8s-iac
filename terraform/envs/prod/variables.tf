variable "cloud_id" {
  description = "ID облака проекта. Создаётся в bootstrap, передаётся через scripts/env-prod.sh"
  type        = string
}

variable "folder_id" {
  description = "ID каталога проекта. Создаётся в bootstrap, передаётся через scripts/env-prod.sh"
  type        = string
}

variable "zone" {
  description = "Зона доступности по умолчанию"
  type        = string
  default     = "ru-central1-a"
}

variable "project" {
  description = "Название проекта"
  type        = string
  default     = "crm-k8s"
}

variable "subnets" {
  description = "Подсети по зонам ключ - зона доступности, значение - CIDR"
  type        = map(string)
  default = {
    "ru-central1-a" = "10.10.1.0/24"
    "ru-central1-b" = "10.10.2.0/24"
    "ru-central1-d" = "10.10.3.0/24"
  }
}

variable "admin_cidrs" {
  description = "Адреса администратора в формате CIDR: доступ к SSH и API Kubernetes"
  type        = list(string)
}
