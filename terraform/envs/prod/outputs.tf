output "masters" {
  description = "Мастера: внутренний и публичный IP"
  value       = module.compute.masters
}

output "workers" {
  description = "Воркеры: внутренний IP"
  value       = module.compute.workers
}

output "ingress_ip" {
  description = "Адресс входа"
  value       = module.balancer.ingress_ip
}