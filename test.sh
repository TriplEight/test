#!/bin/bash

getBlockHeight () {

hexHeight=`curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' localhost:9933 | jq -r .result.block.header.number`

height=$(( $hexHeight ))
}

getBlockHeight
echo $height

if [ $height -gt 10 ]
  then
    echo "Block height already above 10"
  exit 1
else
  while [ $height -lt 11 ]; do
    sleep 2
    getBlockHeight
  echo "Block Height: $height"
  done
  echo "Test passed successfully"
  exit 0
fi
