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

variable "subnet_cidr" {
  description = "Диапазон адресов"
  type        = string
  default     = "10.10.0.0/24"
}
