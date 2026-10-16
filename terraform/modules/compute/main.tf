data "yandex_compute_image" "debian" {
  family = "debian-12"
}

resource "yandex_compute_instance" "master" {
  for_each = var.masters

  name                      = "${var.project}-${each.key}"
  hostname                  = "${var.project}-${each.key}"
  zone                      = each.value
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 50
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.id
      size     = 20
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id          = var.subnet_ids[each.value]
    security_group_ids = [var.security_group_id]
    nat                = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = <<-EOT
      #cloud-config
      ssh_pwauth: false
      users:
        - name: ${var.ssh_user}
          lock_passwd: true
          groups: sudo
          shell: /bin/bash
          sudo: "ALL=(ALL) NOPASSWD:ALL"
          ssh_authorized_keys:
            - ${trimspace(file(pathexpand(var.ssh_public_key_path)))}
    EOT
  }
}

resource "yandex_compute_instance" "worker" {
  for_each = var.workers

  name                      = "${var.project}-${each.key}"
  hostname                  = "${var.project}-${each.key}"
  zone                      = each.value
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 50
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.id
      size     = 40
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = var.subnet_ids[each.value]
    security_group_ids = [var.security_group_id]
    nat                = false
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = <<-EOT
      #cloud-config
      ssh_pwauth: false
      users:
        - name: ${var.ssh_user}
          lock_passwd: true
          groups: sudo
          shell: /bin/bash
          sudo: "ALL=(ALL) NOPASSWD:ALL"
          ssh_authorized_keys:
            - ${trimspace(file(pathexpand(var.ssh_public_key_path)))}
    EOT
  }
}