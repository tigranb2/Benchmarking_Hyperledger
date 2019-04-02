### server specs (for both hyperledger server and client nodes)
##### 4 vCPUs, 15 GB memory
##### Disk: HDD 30GB
##### System: Ubuntu 14.04 LTS

### to install
##### run setup_hl_v0.6.sh and read comments at the bottom to do extra work
#####

## to run

##### current reconfiguration:
##### one hyperledger server node at 10.142.0.6 with `client` file:
##### two hyperledger client nodes at 10.142.0.9, 10.142.0.11
##### with `hosts` file

##### in folder ~/blockbench/benchmark/hyperledger/ of 10.142.0.6 (instance 14)
##### run `./start-root.sh` to fire up the single server node


##### in folders ~/blockbench/benchmark/hyperledger/ of 10.142.0.9 (instance 15)
##### run `./start-clients.sh 3 0 1 5` to fire up two client nodes (with index 0)


##### in folders ~/blockbench/benchmark/hyperledger/ of 10.142.0.11 (instance 16)
##### run `./start-clients.sh 3 1 1 5` to fire up two client nodes (with index 1)

##### so that we have 4 clients (2 @ instance 15, 2 @ instance 16),
##### each client has 3 transactions threads, and
##### each thread issue 5 transactions per second (to execute do-nothing workload)


##### to stop, run `./stop-peers.sh` at instance 14 to stop all servers and clients
##### logs generated see logs folder
