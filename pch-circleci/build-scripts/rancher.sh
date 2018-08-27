#!/usr/bin/env bash

set -e

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source $root/lib/_bootstrap.sh
source $root/lib/_utils.sh
source $root/lib/_rancher.sh

ensure_package "jq"

COMMAND=$1
ENVIRONMENT=$2
SERVICE=$3

case $COMMAND in
    "restart" )
        BATCH_SIZE=$4
        INTERVAL=$5
        restart_service $ENVIRONMENT $SERVICE $BATCH_SIZE $INTERVAL ;;
    "upgrade" )
        IMAGE=$4
        upgrade_service $ENVIRONMENT $SERVICE $IMAGE ;;
    "finish_upgrade" )
        finish_upgrade $ENVIRONMENT $SERVICE ;;
    *)
        die "unknown command: ["$COMMAND"]" ;;
esac
