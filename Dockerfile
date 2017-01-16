FROM phusion/baseimage

MAINTAINER Brian Rimek
LABEL vanda.version="zeppelin-0.6.2-bin-all"
LABEL vanda.release="2017-01-13"

ARG JAVA_MAJOR_VERSION=7
ARG ZEPPELIN_VERSION=0.6.2
ARG ZEPPELIN_WORKDIR=/opt/zeppelin
ARG ZEPPELIN_DOWNLOAD_URL=http://mirror.softaculous.com/apache/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz

# Install Python.
RUN \
  apt-get update && \
  apt-get install -y python3 python3-dev python3-pip python3-virtualenv && \
  apt-get install -y python3-numpy python3-wheel && \
  rm -rf /var/lib/apt/lists/*

# Install R
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | tee -a /etc/apt/sources.list && \
    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | apt-key add - && \
    apt-get update && \
    apt-get install -y r-base r-base-dev

# Install system tools
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip nano vim wget && \
  rm -rf /var/lib/apt/lists/*

# Install Java
RUN \
  echo oracle-java${JAVA_MAJOR_VERSION}-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java${JAVA_MAJOR_VERSION}-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk${JAVA_MAJOR_VERSION}-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-${JAVA_MAJOR_VERSION}-oracle

# Download/Install Zeppelin
RUN mkdir ${ZEPPELIN_WORKDIR}
WORKDIR ${ZEPPELIN_WORKDIR}
RUN \  
  wget ${ZEPPELIN_DOWNLOAD_URL} && \
  tar -xvzf zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz && \
  rm ${ZEPPELIN_WORKDIR}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz && \
  chown -R root:root zeppelin-${ZEPPELIN_VERSION}-bin-all && \
  ln -s ${ZEPPELIN_WORKDIR}/zeppelin-${ZEPPELIN_VERSION}-bin-all ${ZEPPELIN_WORKDIR}/current && \
  mkdir current/logs && \
  touch current/logs/zeppelin-service.log 

# Define ZEPPELIN_HOME variable
ENV ZEPPELIN_HOME ${ZEPPELIN_WORKDIR}/current

# Config Zeppelin as a Service
RUN mkdir /etc/service/zeppelin
ADD files/service_zeppelin_run /etc/service/zeppelin/run

EXPOSE 8080