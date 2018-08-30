#!/bin/bash
set -e -o pipefail

# Inject AWS Secrets Manager Secrets
# Read space delimited list of secret names from SECRETS environment variable
echo "Processing secrets [${SECRETS}]..."
read -r -a secrets <<< "$SECRETS"
for secret in "${secrets[@]}"
do
  vars=$(aws secretsmanager get-secret-value --secret-id $secret \
    --query SecretString --output text \
    | jq -r 'to_entries[] | "export \(.key)='\''\(.value)'\''"')
  eval $vars
done

# Inject runtime environment variables
if [ -f /init/environment ]
then
  echo "Processing environment variables from /init/environment..."
  export $(cat /init/environment | xargs)
fi

# Inject runtime init commands
if [ -f /init/commands ]
then
  echo "Processing commands from /init/commands..."
  source /init/commands
fi

# Run application
exec "$@"