# Runbook: развёртывание bootstrap

Создаёт облако, каталог `prod`, сервисный аккаунт `terraform`, его ключи и бакет под state.
Запускается один раз, от личного аккаунта владельца организации.
Решения и причины — в [ADR 0002](../decisions/0002-bootstrap-layer.md).

## Требования

- `terraform >= 1.6`, `yc` CLI, `jq`, `curl`
- Зеркало провайдеров Яндекса в `~/.terraformrc` (см. [troubleshooting](troubleshooting.md))
- Профиль `yc` авторизован личным аккаунтом с ролью
  `organization-manager.organizations.owner`
- В организации нет облака с именем из переменной `project`
- VPN выключен или Yandex Cloud исключён из туннеля

## Шаги

Из корня репозитория:

```bash
source scripts/env-bootstrap.sh     # YC_TOKEN, TF_VAR_organization_id, TF_VAR_billing_account_id
cd terraform/bootstrap

terraform fmt
terraform init
terraform validate
terraform plan -out=tfplan          # ожидается: 9 to add
terraform apply tfplan
```

`YC_TOKEN` живёт 12 часов. Ошибки авторизации → снова `source scripts/env-bootstrap.sh`.

## Проверка

```bash
terraform output                    # cloud_id, folder_id, bucket видны; ключи — <sensitive>
ls -la ~/.yc/                       # crm-k8s-iac-sa.json с правами -rw-------
yc resource-manager cloud list      # облако проекта в списке
```

В консоли: облако → каталог `prod` → сервисный аккаунт `terraform`
и бакет `<project>-tfstate-<folder_id>` с включённым версионированием.

## Перед коммитом

`git status`: в списке не должно быть `terraform.tfstate`, `tfplan`, `.terraform/`.
`.terraform.lock.hcl` коммитить нужно.

## Откат

```bash
source scripts/env-bootstrap.sh
cd terraform/bootstrap
terraform destroy
```

- Бакет не удалится, пока в нём лежит state (`force_destroy = false`).
  Сначала `destroy` слоя prod.
- Удаление облака отложенное: имя может долго оставаться занятым.
