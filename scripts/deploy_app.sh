#!/bin/bash

# This scripts assumes that the source artifact to be deployed is packaged in the root directory as source.tar.gz

set -eu

DRY_RUN=${DRY_RUN:-false}
export ANSIBLE_HOST_KEY_CHECKING=False

if [ $DRY_RUN = true ]; then
    ansible-playbook --check \
    -i ./ansible/inventories/"$ENV".yml \
    --private-key "$SSH_KEY_FILE" \
    --vault-password-file "$VAULT_PW_FILE" \
    --extra-vars "domain_name=$DOMAIN" \
    ./ansible/playbooks/django_app.yml
else
    ansible-playbook \
    -i ./ansible/inventories/"$ENV".yml \
    --private-key "$SSH_KEY_FILE" \
    --vault-password-file "$VAULT_PW_FILE" \
    --extra-vars "domain_name=$DOMAIN" \
    ./ansible/playbooks/django_app.yml
fi
