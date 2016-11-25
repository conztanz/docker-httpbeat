FROM debian:jessie

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch x-pack beat httpbeat"

COPY ./src/ /run/
RUN chmod +x -R /run

# config
COPY config/httpbeat.yml /.backup/httpbeat/httpbeat.yml
RUN  rm -f /etc/httpbeat/httpbeat.yml

# bin
RUN sh /run/setup/httpbeat.sh \
&&  export PATH=$PATH:/usr/bin

ENV HTTPBEAT_USER="" \
    HTTPBEAT_PWD="changeme" \
    ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PORT="9200"

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["httpbeat", "-c /etc/httpbeat/httpbeat.yml", "-path.config /etc/httpbeat", "-e","-v"]