terraform {
  required_version = ">=1.6" # Версия terraform

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~>0.235"
    }
  }
}

provider "yandex" {
  zone = var.zone
}

resource "yandex_resourcemanager_cloud" "this" {
  name            = var.project
  organization_id = var.organization_id
}

resource "yandex_billing_cloud_binding" "this" {
  billing_account_id = var.billing_account_id
  cloud_id           = yandex_resourcemanager_cloud.this.id
}

resource "yandex_resourcemanager_folder" "prod" {
  name       = "prod"
  cloud_id   = yandex_resourcemanager_cloud.this.id
  depends_on = [yandex_billing_cloud_binding.this]
}

resource "yandex_iam_service_account" "builder" {
  name      = "terraform"
  folder_id = yandex_resourcemanager_folder.prod.id
}

resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = yandex_resourcemanager_folder.prod.id
  role      = "admin"
  member    = "serviceAccount:${yandex_iam_service_account.builder.id}"
}

resource "yandex_iam_service_account_static_access_key" "key" {
  service_account_id = yandex_iam_service_account.builder.id
}

resource "yandex_storage_bucket" "tfstate" {
  bucket     = "${var.project}-tfstate-${yandex_resourcemanager_folder.prod.id}"
  folder_id  = yandex_resourcemanager_folder.prod.id
  access_key = yandex_iam_service_account_static_access_key.key.access_key
  secret_key = yandex_iam_service_account_static_access_key.key.secret_key
  depends_on = [yandex_resourcemanager_folder_iam_member.admin]
  versioning {
    enabled = true
  }
}


