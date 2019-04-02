sudo apt-get update
sudo apt-get upgrade curl

# https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/ubuntu/
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce -y
sudo docker run hello-world

# https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version


# https://golang.org/dl/
wget -q https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.12.1.linux-amd64.tar.gz
sudo su
mkdir go
vim /etc/profile
# append these three lines
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# :wq!
source /etc/profile


# https://github.com/creationix/nvm/blob/master/README.md#installation
# restart the terminal if something did not click
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
command -v nvm
nvm install 8.15.1

mkdir fabric-sample
cd fabric-sample
git clone https://github.com/hyperledger/fabric-samples.git
cd fabric-sample
git checkout release-1.4

sudo su
curl -sSL http://bit.ly/2ysbOFE | bash -s 1.4.0

vim /etc/profile
export PATH=$PATH:/home/systopicsgroup3/fabric-sample/fabric-samples/bin/

# example: https://medium.com/coinmonks/step-by-step-towards-hyperledger-fabric-part-1-c867fc5fe18


git clone https://github.com/ooibc88/blockbench.git
git checkout hyperledger-v1.0_micro
