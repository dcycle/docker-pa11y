#!/bin/bash
# Rebuild script
# This is meant to be run on a regular basis to make sure everything works with
# the latest version of scripts.

set -e

CREDENTIALS="$HOME/.dcycle-docker-credentials.sh"

if [ ! -f "$CREDENTIALS" ]; then
  echo "Please create $CREDENTIALS and add to it:"
  echo "DOCKERHUBUSER=xxx"
  echo "DOCKERHUBPASS=xxx"
  exit;
else
  source "$CREDENTIALS";
fi

DATE=`date '+%Y-%m-%d-%H-%M-%S-%Z'`
MAJORVERSION='1'
VERSION='1.0'

# Start by getting the latest version of the official drupal image
docker pull node
# Rebuild the entire thing
docker build --no-cache -t dcycle/pa11y:"$VERSION" .
docker build -t dcycle/pa11y:"$MAJORVERSION" .
docker build -t dcycle/pa11y:"$MAJORVERSION".$DATE .
docker build -t dcycle/pa11y:"$VERSION".$DATE .
docker login -u"$DOCKERHUBUSER" -p"$DOCKERHUBPASS"
docker push dcycle/pa11y:"$VERSION"
docker push dcycle/pa11y:"$MAJORVERSION"
docker push dcycle/pa11y:"$VERSION"."$DATE"
docker push dcycle/pa11y:"$MAJORVERSION"."$DATE"
# No longer using the latest tag, use the major version tag instead.
