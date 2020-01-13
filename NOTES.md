## Approach
1. I first tried to run the Docker image locally (parity/substrate:2.0.0-31c633c47) and test out the curl commands to fetch the block height
2. However, I received a `curl: (52) Empty reply from server` response from Curl. 
3. Tried to map the host ports of 9933, 9944 and 30333 to the docker container and tried again. But still no go. 
4. Searched the Github issues page for substrate and found `https://github.com/paritytech/substrate/issues/439` which directed me to PR #495 which indicated to use the flags `--ws-external` and `--rpc-external`
5. Added `-r` flag to jq command for raw hex output instead of string
