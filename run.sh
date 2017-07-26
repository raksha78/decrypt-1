#!/bin/bash/ -e
keys=$(cat config.json | jq '.'config.environment.testing.secureKeys | jq 'keys')

shell_array_of_keys=$(echo $keys | jq -r '.[]')

for key in $shell_array_of_keys; do
  value=$(cat config.json | jq -r '.'config.environment.testing.secureKeys.$key)
  echo $value > encrypted.txt
  shippable_decrypt "encrypted.txt"
  echo \n >> encrypted.txt.decrypted
  cat encrypted.txt.decrypted
done;

# cat encrypted.txt.decrypted
# source encrypted.txt.decrypted