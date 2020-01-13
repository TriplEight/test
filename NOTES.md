## Approach
1. I first tried to run the Docker image locally (parity/substrate:2.0.0-31c633c47) and test out the curl commands to fetch the block height
2. However, I received a `curl: (52) Empty reply from server` response from Curl. 
3. Tried to map the host ports of 9933, 9944 and 30333 to the docker container and tried again. But still no go. 
4. Searched the Github issues page for substrate and found `https://github.com/paritytech/substrate/issues/439` which directed me to PR #495 which indicated to use the flags `--ws-external` and `--rpc-external`
5. Added `-r` flag to jq command for raw hex output instead of string
6. Created K8S deployment to run the container. 
7. Connected to container locally using `kubectl port-forward`
8. Created `LoadBalancer` service endpoint for cloud-based K8S cluster deployment

## Run on a cloud based K8S infr
1. Run `kubectl apply -f manifests` to create the Deployment with one Pod and the Service
2. Copy the URL of the Service and pass it to the test script as follows: `bash test.sh load-balancer-url.cloud.com`
3. If the block height is already above 10, the script exits with a non-zero code
4. Once the block height crosses 10, the script exits with a zero code

## Run on a local K8S infra
1. Run `kubectl apply -f manifests`
2. Run `kubectl port-forward <pod-name> 9933:9933`
3. Then run the test script `bash test.sh localhost`

