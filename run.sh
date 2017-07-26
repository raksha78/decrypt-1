#!/bin/bash/ -e

# shippable_decrypt() {
#   local source_file=$1
#   local key_file=$2
#   local temp_dest='/tmp/shippable/decrypt'

#   if [ "$key_file" == "" ]; then
#     key_file=/tmp/ssh/00_sub
#   fi

#   echo "shippable_decrypt: Decrypting $source_file using key $key_file"

#   if [ ! -f "$key_file" ]; then
#     echo "shippable_decrypt: ERROR - Key file $key_file not found"
#     exit 100
#   fi

#   if [ -d "$temp_dest" ]; then
#     rm -r ${temp_dest:?}
#   fi
#   mkdir -p $temp_dest/fragments

#   base64 --decode < "$source_file" > $temp_dest/encrypted.raw
#   split -b 256 "$temp_dest/encrypted.raw" $temp_dest/fragments/
#   local fragments
#   fragments=$(ls -b $temp_dest/fragments)
#   for fragment in $fragments; do
#     openssl rsautl -decrypt -inkey "$key_file" -oaep < "$temp_dest/fragments/$fragment" >> "$source_file.decrypted"
#   done;

#   rm -r ${temp_dest:?}/*
#   echo "shippable_decrypt: Decrypted $source_file to $source_file.decrypted"
# }

#shippable_decrypt "/home/shippable/decrypt/encrypt.txt" "/home/shippable/decrypt/key.pem"

keys=$(cat config.json | jq -r '.'config.environment.testing.secureKeys | jq 'keys')

echo $keys

for key in $keys; do
  echo $key
  $key > encrypted.txt
  cat encrypted.txt
  shippable_decrypt "encrypted.txt" "/tmp/ssh/00_sub"
  cat $source_file.decrypted
  $source_file.decrypted >> \n
done;

source $source_file.decrypted