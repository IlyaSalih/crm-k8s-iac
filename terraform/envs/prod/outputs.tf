output "masters" {
  description = "Мастера: внутренний и публичный IP"
  value       = module.compute.masters
}

output "workers" {
  description = "Воркеры: внутренний IP"
  value       = module.compute.workers
}