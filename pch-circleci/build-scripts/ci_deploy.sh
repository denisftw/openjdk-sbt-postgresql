#!/usr/bin/env bash

set -e

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source $root/lib/_utils.sh

ensureVar CIRCLE_PROJECT_REPONAME

ensureVar RANCHER_API_URL
ensureVar RANCHER_ENV
ensureVar RANCHER_SERVICE

HUB=quay.io
REPO=propertyconnect/$CIRCLE_PROJECT_REPONAME
TAG=`tag_name $CIRCLE_BUILD_NUM $CIRCLE_BRANCH`
: ${TAG_TO_DEPLOY:=$TAG}

echo Deploying $TAG_TO_DEPLOY...

$root/rancher.sh upgrade $RANCHER_ENV $RANCHER_SERVICE $HUB/$REPO:$TAG_TO_DEPLOY
timeout 600 $root/rancher.sh finish_upgrade $RANCHER_ENV $RANCHER_SERVICE
