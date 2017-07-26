#!/bin/bash/ -e
keys=$(cat config.json | jq '.'config.environment.testing.secureKeys | jq 'keys' | jq -r '.[]')

for key in $keys; do
  value=$(cat config.json | jq -r '.'config.environment.testing.secureKeys.$key)
  echo $value > encrypted.txt
  shippable_decrypt "encrypted.txt"
  echo >> encrypted.txt.decrypted
done;
