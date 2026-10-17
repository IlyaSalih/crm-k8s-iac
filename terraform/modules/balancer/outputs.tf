output "ingress_ip" {
  value = yandex_vpc_address.ingress.external_ipv4_address[0].address
}