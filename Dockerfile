FROM openjdk:8u171-jdk-stretch

ENV SBT_VERSION 0.13.15
ENV YARN_VERSION 1.9.2
ENV NODE_VERSION 8.11.3
ENV POSTGRESQL_VERSION 9.6
ENV DOCKER_VERSION 17.03.1-ce

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE ignore

ENV DOCKER_HOME /root/docker
ENV SBT_HOME /root/sbt
ENV NODE_HOME /root/node
ENV YARN_HOME /root/yarn

ENV PATH ${SBT_HOME}/bin:${NODE_HOME}/bin:${YARN_HOME}/bin:${DOCKER_HOME}:${PATH}

WORKDIR /root

RUN mkdir -p "$SBT_HOME"
RUN wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar xz -C $SBT_HOME --strip-components=1
RUN sbt sbtVersion

RUN mkdir -p "$NODE_HOME"
RUN wget -qO - "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" | tar Jx --strip-components=1 -C $NODE_HOME
RUN node --version

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && apt-get install -y postgresql-client-$POSTGRESQL_VERSION

RUN mkdir -p "${YARN_HOME}"
RUN wget -qO - "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" | tar xz -C ${YARN_HOME} --strip-components=1
RUN yarn --version

RUN mkdir -p ${DOCKER_HOME}
RUN wget -qO - "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" | tar xz -C ${DOCKER_HOME} --strip-components=1
RUN docker --version

RUN yarn add @pch-ng/builder