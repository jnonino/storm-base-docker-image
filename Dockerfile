FROM ubuntu:xenial
LABEL maintainer="Julian Nonino <noninojulian@outlook.com>"

# Install required tools, tar, curl and Java JRE
# Install dependencies for Storm and SupervisorD
RUN apt-get update -y && \
    apt-get install -y tar curl openjdk-8-jre-headless && \
    apt-get install -y python-setuptools python-virtualenv supervisor --fix-missing && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Storm
ENV STORM_VERSION 1.1.1
RUN curl -O http://apache.mirror.digionline.de/storm/apache-storm-$STORM_VERSION/apache-storm-$STORM_VERSION.tar.gz && \
    tar -xvf apache-storm-$STORM_VERSION.tar.gz && \
    rm -rf apache-storm-$STORM_VERSION.tar.gz && \
    mv apache-storm-$STORM_VERSION storm && \
    mv storm /opt
ENV STORM_HOME /opt/storm
ENV PATH $STORM_HOME/bin:$STORM_HOME/lib:$PATH
WORKDIR /opt/storm