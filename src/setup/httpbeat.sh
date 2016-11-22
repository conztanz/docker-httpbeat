#!/bin/bash

# miscellaneous
apt-get update -y
apt-get install wget git binutils make -y

# Golang
curl https://glide.sh/get | sh
wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz -P /usr/local
tar -C /usr/local -xzf /usr/local/go1.7.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/work

# httpbeat
mkdir -p $GOPATH/src/github.com/christiangalsterer
cd $GOPATH/src/github.com/christiangalsterer
git clone https://github.com/christiangalsterer/httpbeat
cd httpbeat
make
mv httpbeat /usr/bin/httpbeat

# purge
strip /usr/bin/httpbeat
apt-get -y --purge autoremove  wget git binutils
rm -rf /httpbeat
rm -rf /usr/local/go
rm -f /usr/local/go1.7.1.linux-amd64.tar.gz
