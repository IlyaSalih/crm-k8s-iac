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

variable "masters" {
  description = "Мастера ключ имя машины, значение зона доступности"
  type        = map(string)
  default = {
    "master-1" = "ru-central1-a"
  }
}

variable "workers" {
  description = "Воркеры ключ имя машины, значение зона доступности"
  type        = map(string)
  default = {
    "worker-1" = "ru-central1-a"
    "worker-2" = "ru-central1-b"
    "worker-3" = "ru-central1-d"
  }
}

variable "ssh_user" {
  description = "Имя пользователя при создании ВМ мастера"
  type        = string
  default     = "devops"
}

variable "ssh_public_key_path" {
  description = "Путь к ключу доступа"
  type        = string
  default     = "~/.ssh/crm-k8s.pub"
}