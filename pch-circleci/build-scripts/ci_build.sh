#!/usr/bin/env bash

set -e

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source $root/lib/_utils.sh

ensureVar CIRCLE_PROJECT_REPONAME
ensureVar CIRCLE_BUILD_NUM
ensureVar CIRCLE_BRANCH
ensureVar QUAYIO_USER
ensureVar QUAYIO_PASSWORD

HUB=quay.io
REPO=propertyconnect/$CIRCLE_PROJECT_REPONAME
TAG=`tag_name $CIRCLE_BUILD_NUM $CIRCLE_BRANCH`

docker build -t $HUB/$REPO:$TAG .
docker login -e __unused -u $QUAYIO_USER -p $QUAYIO_PASSWORD $HUB || docker login -u $QUAYIO_USER -p $QUAYIO_PASSWORD $HUB
docker push $HUB/$REPO:$TAG

git tag $TAG
git push --tags

echo $TAG > .tag_to_deploy
