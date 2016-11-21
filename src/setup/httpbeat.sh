#!/bin/bash

# miscellaneous
apt-get update -y
apt-get install wget git binutils -y
wget apt-get install https://storage.googleapis.com/golang/go1.7.1.linux-amd64.tar.gz -P /usr/local
tar -C /usr/local -xzf /usr/local/go1.7.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/work

# httpbeat
mkdir -p $GOPATH/github.com/christiangalsterer
cd $GOPATH/github.com/christiangalsterer
git clone https://github.com/christiangalsterer/httpbeat
cd /httpbeat
git checkout tags/1.2.0
make
mv httpbeat /usr/bin/httpbeat

# purge
strip /usr/bin/httpbeat
apt-get -y --purge autoremove  wget git binutils
rm -rf /httpbeat
rm -rf /usr/local/go
rm -f /usr/local/go1.7.1.linux-amd64.tar.gz