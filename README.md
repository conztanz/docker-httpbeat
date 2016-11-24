[![](https://images.microbadger.com/badges/image/khezen/httpbeat.svg)](https://hub.docker.com/r/khezen/httpbeat/)

# Supported tags and respective `Dockerfile` links

* `1.2.0`, `1.2`, `1`, [(1.2/Dockerfile)](https://github.com/Khezen/docker-httpbeat/blob/1.2/Dockerfile)
* `2.0.0`, `2.0`, `2`, `latest` [(2.0/Dockerfile)](https://github.com/Khezen/docker-httpbeat/blob/2.0/Dockerfile)

# What is Httpbeat?
Httpbeat is a [Beat](https://www.elastic.co/products/beats) used to call HTTP endpoints.
Multiple endpoints can be configured which are polled in a regular interval and the result is shipped to the configured output channel.

Example use cases are:
* Monitor [Apache Stats](https://httpd.apache.org/docs/2.4/mod/mod_status.html)
* Monitor Java application with [Jolokia](https://jolokia.org)
* Monitor [Spring Boot Actuators](http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#production-ready)

[<img src="https://static-www.elastic.co/fr/assets/blt121ead33d4ed1f55/icon-beats-bb.svg?q=455" width="144" height="144">](https://www.elastic.co/fr/products/beats)

# How To Use

## docker engine

```
docker run -d -p 5601:5601 khezen/httpbeat:latest   
```

## docker-compose

### [File Descriptors and MMap](https://www.elastic.co/guide/en/elasticsearch/guide/current/_file_descriptors_and_mmap.html)

run the following command on your host:
```
sysctl -w vm.max_map_count=262144
```
You can set it permanently by modifying `vm.max_map_count` setting in your `/etc/sysctl.conf`.

### docker-compose.yml
```
version: '2'
services:    
    httpbeat:
        image: khezen/httpbeat
        environment:
            HTTPBEAT_USER: httpbeat
            HTTPBEAT_PWD: changeme
            ELASTICSEARCH_HOST: localhost
            ELASTICSEARCH_PORT: 9200
        volumes:
            - /etc/httpbeat:/etc/httpbeat
        network_mode: bridge
        restart: always

```
or

```
version: '2'
services:
    elasticsearch:
        image: khezen/elasticsearch
        environment:
            ELASTIC_PWD: changeme
            KIBANA_PWD: brucewayne
            BEATS_PWD: jdilla
        volumes:
            - /data/elasticsearch:/usr/share/elasticsearch/data
            - /etc/elasticsearch:/usr/share/elasticsearch/config 
        ports:
             - "9200:9200"
             - "9300:9300"
        network_mode: bridge
        restart: always

    kibana:
        links:
            - elasticsearch
        image: khezen/kibana:5
        environment:
            KIBANA_PWD: brucewayne
            ELASTICSEARCH_HOST: elasticsearch
            ELASTICSEARCH_PORT: 9200
        volumes:
            - /etc/kibana:/etc/kibana
        ports:
             - "5601:5601"
        network_mode: bridge
        restart: always
    
    httpbeat:
        links:
            - elasticsearch
        image: khezen/httpbeat
        environment:
            HTTPBEAT_USER: beats
            HTTPBEAT_PWD: jdilla
            ELASTICSEARCH_HOST: elasticsearch
            ELASTICSEARCH_PORT: 9200
        volumes:
            - /etc/httpbeat:/etc/httpbeat
        network_mode: bridge
        restart: always

```
# Environment Variables

##### HTTPBEAT_USER | `(empty by default)`
Elasticsearch user for this beat. If left empty: authentication is not defined in configuration file.

##### HTTPBEAT_PWD | `changeme`
password for elasticsearch user **HTTPBEAT_USER**.

##### ELASTICSEARCH_HOST | `elasticseach`
Elasticsearch hostname.

##### ELASTICSEARCH_PORT | `9200`
Elasticsearch port.

# Configure Httpbeat

Configuration file is located in `/etc/httpbeat/httpbeat.yml` if you follow the same volume mapping as in docker-compose examples above.

You can find help with httpbeat configuration [here](https://github.com/christiangalsterer/httpbeat/blob/master/docs/configuration.asciidoc).

# User Feedback
## Issues
If you have any problems with or questions about this image, please ask for help through a [GitHub issue](https://github.com/Khezen/docker-httpbeat/issues).

# Credit

[christiangalsterer/httpbeat](https://github.com/christiangalsterer/httpbeat)