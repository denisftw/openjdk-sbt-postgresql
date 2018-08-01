FROM circleci/openjdk:8u151-jdk-node-browsers

ENV SBT_VERSION 0.13.15
ENV POSTGRESQL_VERSION 9.6

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE ignore

ENV APP_DIRECTORY /root/app
ENV SBT_HOME /root/sbt

ENV PATH ${SBT_HOME}/bin:${PATH}

WORKDIR /root

RUN sudo yarn add @pch-ng/builder
RUN sudo wget -q https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb
RUN sudo dpkg -i sbt-$SBT_VERSION.deb
RUN sudo apt-get update
RUN sudo apt-get install -y postgresql-client

RUN sudo mkdir -p ${APP_DIRECTORY}
WORKDIR ${APP_DIRECTORY}