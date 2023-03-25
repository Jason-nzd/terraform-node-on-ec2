#!/bin/bash
sudo yum update -y
sudo yum install git -y
sudo yum install iptables -y

echo "Installing Node Version Manager NVM"
touch ~/.bashrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install 16
npm install -g npm@9.6.2

echo "Mapping IP Tables - Routing port 3000 to 80"
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000

git clone "${git_project_url}"
cd "${git_project_folder}"

# todo: setup .env secrets

npm install
npm run build
npm run start
