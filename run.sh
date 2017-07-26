#!/bin/bash/ -e
keys=$(cat config.json | jq '.'config.environment.testing.secureKeys | jq 'keys' | jq -r '.[]')
#shell_array_of_keys=$(echo $keys | jq -r '.[]')
for key in $keys; do
  value=$(cat config.json | jq -r '.'config.environment.testing.secureKeys.$key)
  echo $value > encrypted.txt
  shippable_decrypt "encrypted.txt"
  echo >> encrypted.txt.decrypted
done;

cat encrypted.txt.decrypted
source encrypted.txt.decrypted
rm -rf encrypted.txt.decrypted