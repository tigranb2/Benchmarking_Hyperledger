## Server Specs (for both hyperledger server and client nodes)
##### 4 vCPUs, 15 GB memory
##### Disk: HDD 30GB
##### System: Ubuntu 14.04 LTS

## to install
##### run setup_hl_v0.6.sh and read comments at the bottom to do extra work
#####

## to run

##### current configuration:
##### one hyperledger server node at 10.142.0.6 with `client` file;
##### the server node's `host` file contains only one entry (its internal ip)
##### two hyperledger client nodes at 10.142.0.9, 10.142.0.11 with `hosts` file

##### in folder ~/blockbench/benchmark/hyperledger/ of 10.142.0.6 (instance 14)
##### run `./start-root.sh` to fire up the single server node


##### in folders ~/blockbench/benchmark/hyperledger/ of 10.142.0.9 (instance 15)
##### run `./start-clients.sh 3 0 1 5` to fire up two client nodes


##### in folders ~/blockbench/benchmark/hyperledger/ of 10.142.0.11 (instance 16)
##### run `./start-clients.sh 3 1 1 5` to fire up two client nodes

##### so that we have 4 clients (2 @ instance 15, 2 @ instance 16),
##### each client has 3 transactions threads, and
##### each thread issue 5 transactions per second (to execute do-nothing workload)


##### to stop, run `./stop-peers.sh` at instance 14 to stop all servers and clients
##### a 2.5 miniute transaction log is in logs folder


## ssh

now say I want to SSH from 15 to 14:

at 15, generate pk, sk:

`ssh-keygen -t rsa -f ./test -C systopicsgroup3`

upload the pk (test.pub in this case) to 14, and do:

`mkdir -p ~/.ssh`

`cat test.pub >> ~/.ssh/authorized_keys`

finally, at 15:

`ssh -i test systopicsgroup3_gmail_com@10.142.0.6`

or even better

`ssh -i test -o StrictHostKeyChecking=no systopicsgroup3_gmail_com@10.142.0.6`
` `
