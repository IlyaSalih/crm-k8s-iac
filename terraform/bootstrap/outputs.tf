output "cloud_id" {
  value       = yandex_resourcemanager_cloud.this.id
  description = "Значение cloud_id облака"
}

output "folder_id" {
  value       = yandex_resourcemanager_folder.prod.id
  description = "Значение folder_id каталога"
}


output "access_key" {
  sensitive = true
  value     = yandex_iam_service_account_static_access_key.st_key.access_key

}

output "secret_key" {
  sensitive = true
  value     = yandex_iam_service_account_static_access_key.st_key.secret_key
}

output "bucket" {
  value = yandex_storage_bucket.tfstate.bucket

}