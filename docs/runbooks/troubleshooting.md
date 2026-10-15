# Troubleshooting

Проблемы, которые уже встречались, и как их решать.

## terraform init

**Висит на `Installing yandex-cloud/yandex`.**
Реестр HashiCorp недоступен или медленный (часто из-за VPN). Решение — зеркало Яндекса
в `~/.terraformrc`:

```hcl
provider_installation {
  network_mirror {
    url     = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```

После прерванного `init` удалить недокачанное: `rm -rf .terraform .terraform.lock.hcl`.

**Терминал завис и не реагирует на Ctrl+C.**
Закрыть терминал, затем `pgrep -a terraform`; если процесс жив —
`pkill terraform`, при необходимости `pkill -9 terraform`.

**Warning: Incomplete lock file information for providers.**
Из-за зеркала контрольные суммы посчитаны только для текущей платформы (`linux_amd64`).
На Linux и в CI на Linux не мешает. На другой ОС `init` упадёт на проверке lock-файла.

## Сеть

**Yandex Cloud рвёт соединения при включённом VPN.**
Выключить VPN на время работы или исключить из туннеля домены
`api.cloud.yandex.net`, `storage.yandexcloud.net`, `terraform-mirror.yandexcloud.net`.

## Ошибки в коде Terraform

| Сообщение | Причина |
|---|---|
| `An argument named "..." is not expected here` | Аргумента нет у этого блока. В `variable` значение задаётся через `default` |
| `Reference to undeclared resource` | Ссылка не совпадает с заголовком ресурса символ в символ |
| Значение ушло в API текстом | Ссылка взята в кавычки без `${}` |
| `Output "..." not found` | Имя в `terraform output` не совпадает с именем в `outputs.tf` |

`terraform validate` проверяет синтаксис, но не смысл: забытый `depends_on`
или опечатка в имени поля внутри `jsonencode` им не ловятся.

## Скрипты окружения

| Симптом | Причина |
|---|---|
| Переменные пустые после запуска | Скрипт запущен как `./script.sh`, нужен `source` |
| Terraform спрашивает переменные | Не выполнен `source` в этом терминале |
| В переменной пусто, ошибки не было | Команда внутри `$( )` упала молча; проверить её отдельно в терминале |
| `export X = ...` не работает | Пробелы вокруг `=` в bash недопустимы |

`${ИМЯ}` подставляет переменную, `$(команда)` подставляет вывод команды.
Проверка скриптов: `shellcheck scripts/*.sh`.

## Git

**Переименовал файл через `mv`, а не `git mv`.**
`git add -A <папка>` — git сам распознает переименование.

**Закоммитил state или ключ в публичный репозиторий.**
Удаления недостаточно, ключи считаются скомпрометированными:

```bash
git rm --cached <файл> && git commit -m "..." && git push
cd terraform/bootstrap
terraform apply -replace=yandex_iam_service_account_key.acc_key \
                -replace=yandex_iam_service_account_static_access_key.st_key
```
