resource "yandex_vpc_network" "this" {
  name = "${var.project}-network"
}


resource "yandex_vpc_subnet" "this" {
  name           = "${var.project}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.subnet_cidr]
}