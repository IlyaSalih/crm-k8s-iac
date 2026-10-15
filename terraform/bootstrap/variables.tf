variable "organization_id" {
  description = "ID организации, в которой создается облако"
  type        = string
}

variable "billing_account_id" {
  description = "ID платежного аккаунта к которому привязывается облако"
  type        = string
}

variable "project" {
  description = "Имя проекта: имя облака и префикс для остальных ресурсов"
  type        = string
  default     = "crm-k8s"
}

variable "zone" {
  description = "Зона доступности по умолчанию"
  type        = string
  default     = "ru-central1-a"
}