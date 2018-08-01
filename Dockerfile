FROM circleci/openjdk:8u151-jdk-node-browsers

ENV SBT_VERSION 0.13.15
ENV PATH ${SBT_HOME}/bin:${PATH}

WORKDIR /root

RUN sudo wget -q https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb
RUN sudo dpkg -i sbt-$SBT_VERSION.deb
RUN sudo apt-get update
RUN sudo apt-get install -y postgresql-client
