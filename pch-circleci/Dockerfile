FROM ubuntu:16.04

WORKDIR /root

ENV NODE_VERSION    v8.11.4
ENV SBT_VERSION     0.13.15
ENV PG_VERSION      9.6
ENV NVM_DIR         /root/nvm
ENV SBT_HOME        /root/sbt
ENV BUILD_SCRIPTS   /root/build-scripts
ENV NODE_PATH       $NVM_DIR/versions/node/$NODE_VERSION/lib/node_modules
ENV PATH            ${SBT_HOME}/bin:$NVM_DIR/versions/node/$NODE_VERSION/bin:${BUILD_SCRIPTS}:$PATH

RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
        jq \
        openjdk-8-jdk \
        lsb-release \
        software-properties-common

ADD build-scripts   ${BUILD_SCRIPTS}

RUN mkdir -p ${NVM_DIR}
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"
RUN npm install -g npm

RUN mkdir -p ${SBT_HOME}
RUN wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar xz -C $SBT_HOME --strip-components=1
RUN sbt sbtVersion

RUN add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main"
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && apt-get install -y postgresql-client-${PG_VERSION}
