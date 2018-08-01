FROM circleci/openjdk:8u151-jdk-node-browsers

USER circleci

ENV SBT_VERSION 0.13.15

WORKDIR /home/circleci

RUN wget -q https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb
RUN sudo dpkg -i sbt-$SBT_VERSION.deb
RUN sudo apt-get update
RUN sudo apt-get install -y postgresql-client
