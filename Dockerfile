FROM        ubuntu:12.10

MAINTAINER  Tim Cash, timcash@gmail.com

# INSTALL OS DEPENDENCIES AND NEO4J

# add community-maintained universe repository to sources
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list

# date packages were last updated
ENV REFRESHED_AT 2014-01-14
ENV DEBIAN_FRONTEND noninteractive
# resynchronize package index files from their sources
RUN apt-get -qq update

# install software-properties-common (ubuntu >= 12.10) to be able to use add-apt-repository
RUN apt-get -qq -y install software-properties-common
# add PPA for java
RUN add-apt-repository ppa:webupd8team/java
# resynchronize package index files from their sources
RUN apt-get -qq update

# accept Oracle license
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
# install jdk7
RUN apt-get -qq -y install oracle-java7-installer
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN apt-get install -y wget
RUN wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
RUN echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list

ADD neo4j-server.properties /etc/neo4j/neo4j-server.properties
RUN apt-get update
RUN apt-get install -y neo4j

EXPOSE 7474

ENTRYPOINT  ["service", "neo4j-service", "start"]