variable "project" {
  description = "Префикс для имен ресурсов"
  type        = string
}

variable "subnet_ids" {
  description = "ID подсетей из модуля network ключ - зона, значение - ID подсети"
  type        = map(string)

}

variable "security_group_id" {
  description = "Группа безопасности для всех VM"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Путь к публичному ключу"
  type        = string
}

variable "masters" {
  description = "Мастера - имя, зона"
  type        = map(string)
}

variable "workers" {
  description = "Воркеры - имя, зона"
  type        = map(string)
}

variable "ssh_user" {
  description = "Имя пользователя, которого создаст cloud-init"
  type        = string
}