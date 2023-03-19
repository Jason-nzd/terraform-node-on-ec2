#!/bin/bash
sudo yum update -y
sudo yum install git -y
sudo yum install iptables -y

echo "Installing Node Version Manager NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 16
node -e "console.log('Testing Node.js ' + process.version)"

echo "Mapping IP Tables - Routing port 3000 to 80"
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000

git clone https://github.com/Jason-nzd/supermarket-prices-nextjs
cd supermarket-prices-nextjs

npm install
npm run build
npm run start
