FROM        ubuntu:12.10

MAINTAINER  Tim Cash, timcash@gmail.com

# INSTALL OS DEPENDENCIES AND NEO4J
RUN wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
RUN echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
RUN apt-get update
RUN apt-get -y install neo4j

ENTRYPOINT  ["service", "neo4j-service", "start"]