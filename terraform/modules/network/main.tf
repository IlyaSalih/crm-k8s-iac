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

resource "yandex_vpc_security_group" "this" {
  name       = "${var.project}-sg"
  network_id = yandex_vpc_network.this.id
  ingress {
    description    = "SSH"
    port           = 22
    protocol       = "TCP"
    v4_cidr_blocks = var.admin_cidrs
  }
  ingress {
    description    = "kubectl"
    port           = 6443
    protocol       = "TCP"
    v4_cidr_blocks = var.admin_cidrs
  }
  ingress {
    description       = "Весь трафик между нодами внутри кластера"
    from_port         = 0
    to_port           = 65535
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }
  ingress {
    description    = "HTTP от балансировщика к ingress-nginx (NodePort)"
    port           = 30080
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description    = "HTTPS от балансировщика к ingress-nginx (NodePort)"
    port           = 30443
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description       = "healthcheck"
    from_port         = 0
    to_port           = 65535
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }

  egress {
    description    = "Исходящий трафик"
    from_port      = 0
    to_port        = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}



 