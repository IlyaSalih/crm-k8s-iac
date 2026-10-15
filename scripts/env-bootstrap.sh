#!/bin/bash

export YC_TOKEN=$(yc iam create-token)
export TF_VAR_organization_id=$(yc organization-manager organization list --format json | jq -r '.[0].id')
export TF_VAR_billing_account_id=$(curl -s -H "Authorization: Bearer $YC_TOKEN" https://billing.api.cloud.yandex.net/billing/v1/billingAccounts | jq -r '.billingAccounts[0].id')
