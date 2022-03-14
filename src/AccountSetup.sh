#!/bin/bash

# set -x # Debug output for this command

tokensJsonFile=$1


for row in $(jq -c ' map(.) | .[]' $tokensJsonFile); do
  _jq() {
    echo ${row} | jq -r "${1}"
  }
  name=$(_jq '.Name')
  tokenId=$(_jq '.TokenId')
  tokenSecret=$(_jq '.TokenSecret')
  netsuiteAccount=$(_jq '.NetsuiteAccount')

  echo "##[group]account_steup.sh parameters"
  echo "##[debug]name: $name"
  echo "##[debug]tokenId: $tokenId"
  # echo "##[debug]tokenSecret: $tokenSecret"
  echo "##[debug]netsuiteAccount: $netsuiteAccount"
  echo "##[endgroup]"

  for directory in */ ; do
    cd $directory
    echo "##[debug]Adding Auth to $directory"

    suitecloud account:savetoken --account $netsuiteAccount --authid $name --tokenid $tokenId --tokensecret $tokenSecret
    cd ..
  done
done
