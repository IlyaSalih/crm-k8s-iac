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

