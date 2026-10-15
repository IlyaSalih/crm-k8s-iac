# Runbook: работа со слоем prod

Слой prod работает от сервисного аккаунта `terraform`, state хранится в бакете.
Требует развёрнутого bootstrap. Подробности — в [ADR 0003](../decisions/0003-layers-and-credentials.md).

## Начало работы

В **новом терминале** (без `YC_TOKEN` от bootstrap), из корня репозитория:

```bash
source scripts/env-prod.sh
cd terraform/envs/prod
terraform init -backend-config="bucket=$TF_STATE_BUCKET"
```

`init` нужно повторять после клонирования репозитория, добавления модуля
или изменения настроек backend.

## Проверка окружения

```bash
echo $TF_VAR_cloud_id $TF_VAR_folder_id $TF_STATE_BUCKET
echo ${#AWS_SECRET_ACCESS_KEY}      # длина секрета, сам секрет не выводить
```

Если Terraform спрашивает `cloud_id` или `folder_id` интерактивно —
не выполнен `source scripts/env-prod.sh`.

## Обычный цикл

```bash
terraform fmt
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

## Признаки, что всё настроено

- `init`: `Successfully configured the backend "s3"!`
- В папке `envs/prod` не появляется `terraform.tfstate`: state в бакете
  по пути `prod/terraform.tfstate`
