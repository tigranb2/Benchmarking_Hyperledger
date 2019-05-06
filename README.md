## Server Specs (for both hyperledger server and client nodes)
##### 4 vCPUs, 15 GB memory
##### Disk: HDD 30GB
##### System: Ubuntu 14.04 LTS

## to install
##### run setup_hl_v0.6.sh
#####

## benchmark workflow (3 server, 3 clients)

run `chmod 400 id` to secure the SSH private key if you are using the code for the first time

if nodes' public ips have changed (after server restart), modify `servers.sh`

if nodes' private ips have changed (add/remove node in GCP), check files in client and server folders (clinet/hosts: all hl servers, each appear twice)

if hl root server private ip have changed, go to `functions.sh` and modify `hl_root_private_ip`

in `test.sh` (run == make function all == uncomment the command):

run `copy_configs`, and for sanity check, run `remove_logs`

adjust artificial latency

run `start_servers`, and `start_clients` followed by two parameters: # of threads per client driver, and # of Tx send per thread

after a while (1-5 minutes), SSH to the hl root instance, go to folder `~/blockbench/benchmark/hyperledger`, run `. stop-peers.sh`
(this step cannot be automated due to some strange SSH issue)

repeat the previous two steps if you want to test on different `start_clients` parameters

run `download_logs` and finally `remove_logs` so that logs are this folder


## about ssh

now say I want to SSH from 15 to 14:

at 15, generate pk, sk:

`ssh-keygen -t rsa -f ./id -C systopicsgroup3`

upload the pk (test.pub in this case) to 14, and do:

``

`mkdir -p ~/.ssh && cat id.pub >> ~/.ssh/authorized_keys`

finally, at 15:

`ssh -i test systopicsgroup3_gmail_com@10.142.0.6`

or even better

ssh 10.150.0.29
`ssh -i ~/mgmt/id -o StrictHostKeyChecking=no systopicsgroup3_gmail_com@10.150.0.29`
`ssh -i id -o StrictHostKeyChecking=no systopicsgroup3_gmail_com@35.230.173.211`



