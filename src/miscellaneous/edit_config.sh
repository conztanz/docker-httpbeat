#!/bin/bash

# CREDENTIALS
if [ "$HTTPBEAT_USER" != "" ]; then
    sed -ri "s/elasticsearch.username:[^\r\n]*/elasticsearch.username: $HTTPBEAT_USER/" /etc/httpbeat/httpbeat.yml
    sed -ri "s/elasticsearch.password:[^\r\n]*/elasticsearch.password: $HTTPBEAT_PWD/" /etc/httpbeat/httpbeat.yml
fi
# ELASTICSEARCH URL
sed -ri "s/elasticsearch.hosts:[^\r\n]*/elasticsearch.hosts: [\"http:\/\/$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT\"]/" /etc/httpbeat/httpbeat.yml
