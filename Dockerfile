FROM circleci/openjdk:8u181-jdk-node-browsers

USER circleci

ENV SBT_VERSION 1.2.8

WORKDIR /home/circleci

RUN wget -q https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb
RUN sudo dpkg -i sbt-$SBT_VERSION.deb
RUN sudo apt-get update
RUN sudo apt-get install -y postgresql-client

RUN sbt sbtVersion
RUN rm -rf sbt-$SBT_VERSION.deb
RUN rm -rf project
