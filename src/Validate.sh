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

  echo "##[group]validate.sh parameters"
  echo "##[debug]name: $name"
  echo "##[debug]tokenId: $tokenId"
  # echo "##[debug]tokenSecret: $tokenSecret"
  echo "##[debug]netsuiteAccount: $netsuiteAccount"
  echo "##[endgroup]"

  for directory in */ ; do
    cd $directory
    echo "##[debug]Validating $directory"

    # update the project json to include the current authId to validate against
    printf "{\"defaultAuthId\": \"%s\"}" $name > project.json
    cat project.json | jq

    suitecloud project:validate --server

    # if the result of the npm command is not 0 then throw and stop the 'build'
    if [ $? -ne 0 ]
    then
      return 1
    fi

    cd ..
  done
done
