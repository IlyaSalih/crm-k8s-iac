resource "yandex_lb_target_group" "workers" {
  name = "${var.project}-workers"
  dynamic "target" {
    for_each = var.targets
    content {
      subnet_id = target.value.subnet_id
      address   = target.value.ip
    }
  }
}

resource "yandex_vpc_address" "ingress" {
  name = "${var.project}-ingress-ip"

  external_ipv4_address {
    zone_id = var.zone
  }
}

resource "yandex_lb_network_load_balancer" "ingress" {
  name = "${var.project}-balancer"

  listener {
    name        = "http"
    port        = 80
    target_port = var.http_node_port

    external_address_spec {
      address    = yandex_vpc_address.ingress.external_ipv4_address[0].address
      ip_version = "ipv4"
    }
  }

  listener {
    name        = "https"
    port        = 443
    target_port = var.https_node_port

    external_address_spec {
      address    = yandex_vpc_address.ingress.external_ipv4_address[0].address
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.workers.id

    healthcheck {
      name = "tcp"
      tcp_options {
        port = var.https_node_port
      }
    }
  }
}