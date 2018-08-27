#!/usr/bin/env bash

set -e

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source $root/lib/_utils.sh

ensureVar CIRCLE_PROJECT_USERNAME
ensureVar CIRCLE_PROJECT_REPONAME
ensureVar CIRCLE_BUILD_NUM
ensureVar CIRCLE_BRANCH
ensureVar CIRCLE_SHA1

ensureVar CIRCLE_API_TOKEN

TAG=`tag_name $CIRCLE_BUILD_NUM $CIRCLE_BRANCH`

if [ "${CIRCLE_BRANCH}" == "master" ]; then
  curl --user ${CIRCLE_API_TOKEN}: \
    --data build_parameters[CIRCLE_JOB]=deploy \
    --data build_parameters[TAG_TO_DEPLOY]=$TAG \
    --data revision=$CIRCLE_SHA1 \
    https://circleci.com/api/v1.1/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/tree/$CIRCLE_BRANCH
fi
