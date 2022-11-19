#!/bin/bash

# Instalando o client NFS
apt-get install nfs-common -y

# Montando o diretório do Node Master
mount 10.10.10.100:/var/lib/docker/volumes/app/_data /var/lib/docker/volumes/app/_data