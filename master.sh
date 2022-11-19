#!/bin/bash
sudo docker swarm init --advertise-addr=10.10.10.100
sudo docker swarm join-token worker | grep docker > /vagrant/worker.sh

# Criando um volume de dados
docker volume create app

# instalando o NFS
apt-get install nfs-server -y

# exportando o volume
echo 'index.html /var/lib/docker/volumes/app/_data *(rw,sync,subtree_check)' >> /etc/exports
exportfs -ar

# Movendo a aplicação para dentro do volume 
mv index.html /var/lib/docker/volumes/app/_data

# Criando o serviço da aplicação
docker service create --name meu-app --replicas 15 -p 80:80 httpd -dt -p 80:80 --mount type=volume,src=app,dst=/usr/local/apache2/htdocs httpd