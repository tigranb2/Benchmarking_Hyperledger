. servers.sh

ssh_username="systopicsgroup3_gmail_com"

hl_folder="~/blockbench/benchmark/hyperledger"
config_folder="$hl_folder/data/go/src/github.com/hyperledger/fabric/consensus/pbft"

hl_root_private_ip="10.10.1.1"

function copy_configs() {
  for i in ${hl_servers[@]}; do 
    echo $i
    scp -i id -o StrictHostKeyChecking=no server/hosts $ssh_username@$i:$hl_folder
    scp -i id -o StrictHostKeyChecking=no server/clients $ssh_username@$i:$hl_folder
    scp -i id -o StrictHostKeyChecking=no server/hl_consensus_3.yaml $ssh_username@$i:$config_folder/config.yaml
  done

  for i in ${hl_clients[@]}; do 
    echo $i
    scp -i id -o StrictHostKeyChecking=no client/hosts $ssh_username@$i:$hl_folder
  done
}

function remove_logs() {
  for i in ${hl_servers[@]}; do 
    echo $i
    ssh -i id -o StrictHostKeyChecking=no $ssh_username@$i "cd $hl_folder; rm logs -rf; rm *.zip"
  done

  for i in ${hl_clients[@]}; do 
    echo $i
    ssh -i id -o StrictHostKeyChecking=no $ssh_username@$i "cd $hl_folder; rm logs -rf; rm *.zip"
  done
}

function start_servers() {
  ssh -i id -o StrictHostKeyChecking=no $ssh_username@${hl_servers[0]} "cd $hl_folder; . start-root.sh"
  ssh -i id -o StrictHostKeyChecking=no $ssh_username@${hl_servers[1]} "cd $hl_folder; . start-slave.sh $hl_root_private_ip 1"
  ssh -i id -o StrictHostKeyChecking=no $ssh_username@${hl_servers[2]} "cd $hl_folder; . start-slave.sh $hl_root_private_ip 2"
}

function start_clients() {
  # $1 == # of threads
  # $2 == tx rate
  ssh -i id -o StrictHostKeyChecking=no $ssh_username@${hl_clients[0]} "cd $hl_folder; . start-clients.sh $1 0 3 $2"
  ssh -i id -o StrictHostKeyChecking=no $ssh_username@${hl_clients[1]} "cd $hl_folder; . start-clients.sh $1 1 3 $2"
  ssh -i id -o StrictHostKeyChecking=no $ssh_username@${hl_clients[2]} "cd $hl_folder; . start-clients.sh $1 2 3 $2"
}

function download_logs() {
  for i in ${hl_servers[@]}; do 
    echo $i
    scp -r -i id -o StrictHostKeyChecking=no $ssh_username@$i:$hl_folder/logs ./logs
  done

  for i in ${hl_clients[@]}; do 
    echo $i
    scp -r -i id -o StrictHostKeyChecking=no $ssh_username@$i:$hl_folder/logs ./logs
  done
}

