#!/bin/bash
mkdir -p /etc/httpbeat

if [ ! -f /etc/httpbeat/httpbeat.yml ]; then
    cp /.backup/httpbeat/httpbeat.yml /etc/httpbeat/httpbeat.yml
fi