output "masters" {
  value = { for name, vm in yandex_compute_instance.master : name => {
    internal_ip = vm.network_interface[0].ip_address
    public_ip   = vm.network_interface[0].nat_ip_address
  } }
}

output "workers" {
  value = { for name, vm in yandex_compute_instance.worker : name => vm.network_interface[0].ip_address }
}