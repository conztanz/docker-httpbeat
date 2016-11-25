#!/bin/bash
mkdir -p /etc/httpbeat

if [ ! -f /etc/httpbeat/httpbeat.yml ]; then
    cp /.backup/httpbeat/httpbeat.yml /etc/httpbeat/httpbeat.yml
fi

if [ ! -f /etc/httpbeat/httpbeat.template.json ]; then
    cp /.backup/httpbeat/httpbeat.template.json /etc/httpbeat/httpbeat.template.json
fi

if [ ! -f /etc/httpbeat/httpbeat.template-es2x.json ]; then
    cp /.backup/httpbeat/httpbeat.template-es2x.json /etc/httpbeat/httpbeat.template-es2x.json
fi