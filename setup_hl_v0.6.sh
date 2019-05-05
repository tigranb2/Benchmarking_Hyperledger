mgmt=$(pwd)
echo "install dependencies"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install build-essential linux-headers-$(uname -r) -y
sudo apt-get install libelf-dev libnuma-dev liblz4-dev -y
sudo apt-get install pciutils pkg-config mlocate git make zip -y
sudo apt-get install autoconf automake libtool -y
sudo apt-get install libffi-dev -y
sudo apt-get install libcurl4-openssl-dev -y
sudo ionice -c3 updatedb

# https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/ubuntu/
echo "install docker"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce -y

echo "pull blockbench (and hyperledger) from Github"
cd ~
git clone https://github.com/ooibc88/blockbench.git
cd ~/blockbench/benchmark/hyperledger
# why sudo? without sudo this script won't even run
sudo /bin/bash install.sh  
# the second workaround we mentioned in the presentation
sudo chmod o+rw data/

echo "install restclient-cpp"
cd ~/blockbench
git clone https://github.com/mrtazz/restclient-cpp.git
cd restclient-cpp
./autogen.sh
./configure
sudo make install
sudo ldconfig # https://www.cnblogs.com/youxin/p/5116243.html

echo "compile macro workloads"
cd ~/blockbench/src/macro/kvstore/
cat Makefile
sed -i '2 s/-Wall //' Makefile
sed -i '3 s/-lrestclient-cpp/-lrestclient-cpp -lcurl/' Makefile
make
cd ../smallbank
make
cd ~

echo "install micro workloads"
sudo apt install nodejs npm -y
npm config set strict-ssl false
cd ~/blockbench/src/micro/
npm install

cd $mgmt
mkdir -p ~/.ssh
cat id.pub >> ~/.ssh/authorized_keys

# then I generate one ssh key at the seed instance,
# and later on replicate the disk so that every instance can have the same key
# https://stackoverflow.com/questions/30060046/ssh-permission-denied-publickey
# see the last answer on how to generate ssh keys.


# if there's a server node reconfiguration,
# you may need to change config.yaml in
# ~/blockbench/benchmark/hyperledger/data/go/src/github.com/hyperledger/fabric/consensus/pbft

# for env variables and log directories, check env.sh in
#  ~/blockbench/benchmark/hyperledger/
# that's also where you adjust hosts, clients ip table

# if the script you write cannot run, check:
# https://askubuntu.com/questions/1027000/modify-permissions-to-rwxr-xr-x
