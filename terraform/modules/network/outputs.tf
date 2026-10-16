output "network_id" {
  value = yandex_vpc_network.this.id
}

output "security_group_id" {
  value = yandex_vpc_security_group.this.id
}

output "subnet_ids" {
  value = { for zone, subnet in yandex_vpc_subnet.this : zone => subnet.id }
}