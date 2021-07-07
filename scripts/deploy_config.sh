#!/bin/bash

# This scripts assumes that the configuration files to be deployed are in the root directory under config/<env>/

set -eu

DRY_RUN=${DRY_RUN:-false}
export ANSIBLE_HOST_KEY_CHECKING=False

if [ $DRY_RUN = true ]; then
    ansible-playbook --check \
    -i ./ansible/inventories/"$ENV".yml \
    --private-key "$SSH_KEY_FILE" \
    --vault-password-file "$VAULT_PW_FILE" \
    ./ansible/playbooks/django_app_config.yml
else
    ansible-playbook \
    -i ./ansible/inventories/"$ENV".yml \
    --private-key "$SSH_KEY_FILE" \
    --vault-password-file "$VAULT_PW_FILE" \
    ./ansible/playbooks/django_app_config.yml
fi
