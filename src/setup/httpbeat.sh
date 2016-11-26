#!/bin/bash

# miscellaneous
apt-get update -y
apt-get install -y wget git binutils curl make
pip install -U pip
pip install virtualenv

# Golang
wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz -P /usr/local
tar -C /usr/local -xzf /usr/local/go1.7.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/work

# httpbeat
mkdir -p $GOPATH/src/github.com/christiangalsterer
cd $GOPATH/src/github.com/christiangalsterer
git clone https://github.com/christiangalsterer/httpbeat
cd httpbeat
git checkout tags/2.0.0
make
mv httpbeat /usr/bin/httpbeat

cp /.backup/httpbeat/httpbeat.yml ./etc/httpbeat.yml
cp -a ./etc/. /.backup/httpbeat/
cp /.backup/httpbeat/httpbeat.template.json /.backup/httpbeat/httpbeat.template-es2x.json


#purge
strip /usr/bin/httpbeat
apt-get -y --purge autoremove wget curl git binutils
rm -rf /httpbeat
rm -rf /usr/local/go
rm -f /usr/local/go1.7.1.linux-amd64.tar.gz
