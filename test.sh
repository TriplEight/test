#!/bin/bash

# Get the hostname as command line argument
host=$1

# Test host reachability
if curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' -s $host:9933; then
  echo "Server reachable"
else
  echo "Unable to reach host. Please check again"
  exit 0
fi

# Function that stores the block height in Hex into $hexHeight and then parses it into Int and stores it in $height

getBlockHeight () {

hexHeight=`curl -s -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' $host:9933 | jq -r .result.block.header.number`

height=$(( $hexHeight ))

}

# Invoke the function to initialise the variables
getBlockHeight

# Verify if block height has already surpassed 10
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
