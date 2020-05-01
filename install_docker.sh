#!/bin/bash
set -x
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common tmux sudo apt gnupg2 pass
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
sudo apt-get install -y httping
sudo apt-get install -y jq

sudo apt-get install nfs-kernel-server
sudo mkdir -p /mnt/sharedfolder
sudo chown nobody:nogroup /mnt/sharedfolder
sudo chmod 777 /mnt/sharedfolder
sudo nano /etc/exports
/mnt/sharedfolder 192.168.56.1/24(rw,sync,no_subtree_check)
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
sudo ufw allow from 192.168.56.1/24 to any port nfs
sudo ufw status

# the username needs to be changed
while IFS= read -r line; do
  sudo usermod -aG docker $line
done < <( ls -l /users | grep 4096 | cut -d' ' -f3 )
