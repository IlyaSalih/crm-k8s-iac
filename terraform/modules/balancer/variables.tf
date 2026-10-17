variable "project" {
  description = "Префикс для имён ресурсов"
  type        = string
}

variable "targets" {
  description = "Воркеры за балансировщиком: ключ — имя, значение — подсеть и IP"
  type = map(object({
    subnet_id = string
    ip        = string
  }))
}

variable "zone" {
  type    = string
  default = "ru-central1-d"
}

variable "http_node_port" {
  type    = number
  default = "30080"
}

variable "https_node_port" {
  type    = number
  default = "30443"
}
