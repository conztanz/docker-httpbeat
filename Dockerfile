FROM debian:jessie

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch x-pack beat httpbeat"

COPY ./src/ /run/
RUN chmod +x -R /run

# bin
RUN sh /run/setup/httpbeat.sh \
&&  export PATH=$PATH:/usr/bin

# config
RUN mkdir -p /.backup/httpbeat/
COPY config/httpbeat.yml /.backup/httpbeat/httpbeat.yml

ENV HTTPBEAT_USER="" \
    HTTPBEAT_PWD="changeme" \
    ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PORT="9200"

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["httpbeat", "-c /etc/httpbeat/httpbeat.yml"]