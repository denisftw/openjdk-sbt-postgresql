FROM openjdk:8u171-jdk-stretch

WORKDIR /root

ENV SBT_VERSION 0.13.15
ENV SBT_HOME /root/sbt
ENV NODE_VERSION 8.11.3
ENV NODE_HOME /root/node
ENV PATH ${PATH}:${SBT_HOME}/bin:${NODE_HOME}/bin

RUN mkdir -p "$SBT_HOME"

RUN wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar xz -C $SBT_HOME --strip-components=1

RUN sbt sbtVersion

RUN mkdir -p "$NODE_HOME"

RUN wget -qO - "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" | tar Jx --strip-components=1 -C $NODE_HOME

RUN node --version