resource "yandex_vpc_network" "this" {
  name = "${var.project}-network"
}


resource "yandex_vpc_subnet" "this" {
  name           = "${var.project}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.subnet_cidr]
  route_table_id = yandex_vpc_route_table.table.id
}

resource "yandex_vpc_gateway" "nat" {
  name = "${var.project}-nat"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "table" {
  name       = "${var.project}-rt"
  network_id = yandex_vpc_network.this.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}



 