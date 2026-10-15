#!/bin/bash

# Запускать скрипт нужно из корня проекта, иначе переменные окружения не будут установлены корректно

export TF_VAR_cloud_id=$(terraform -chdir=terraform/bootstrap output -raw cloud_id)
export TF_VAR_folder_id=$(terraform -chdir=terraform/bootstrap output -raw folder_id)
export TF_STATE_BUCKET=$(terraform -chdir=terraform/bootstrap output -raw bucket)
export AWS_ACCESS_KEY_ID=$(terraform -chdir=terraform/bootstrap output -raw access_key)
export AWS_SECRET_ACCESS_KEY=$(terraform -chdir=terraform/bootstrap output -raw secret_key)
export YC_SERVICE_ACCOUNT_KEY_FILE="$HOME/.yc/crm-k8s-iac-sa.json"
